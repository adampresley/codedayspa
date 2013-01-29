#
# Fabric deployment control script
# Author:
#    Adam Presley
#
# Requisites:
#    * fabric
#    * boto
#    * pycrypto (Windows: http://www.voidspace.org.uk/python/modules.shtml#pycrypto)
#    * Environment variables for boto: AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
#    
# To run:
#    fab amazon production updateService -i /path/to/keyfile
#
from __future__ import with_statement

import fabric, boto
import boto.ec2, time
import os, os.path, re
import shutil

from fabric.api import *
from fabric.colors import green, yellow, red
from boto.ec2.connection import EC2Connection

#
# * DEPLOY_ROOT - Root path to the application code
# * REPO - Git repository URL
# * REPO_REMOTE_ORIGIN - Name of the remote origin 
# * REPO_REMOTE_BRANCH - Name of the branch found at origin
# * INSTANCE_NAME - Value for tag "Name" found in Amazon instances 
DEPLOY_ROOT = "/webapps/codedayspa"
REPO = "git://github.com/adampresley/codedayspa.git"
REPO_REMOTE_ORIGIN = "origin"
REPO_REMOTE_BRANCH = "master"

INSTANCE_NAME = "codedayspa"


#####################################################################
# SUPPORTING METHODS
#####################################################################

#
# Function: _getInstances
# Returns an array of Amazon instance objects that match our 
# environment and tag criteria.
#
# Author: 
#    Adam Presley
#
def _getInstances(environmentName = None):
	connection = EC2Connection()
	reservations = connection.get_all_instances()
	instances = []

	print ""
	print green("** Getting instances **")

	for reservation in reservations:
		for instance in reservation.instances:
			if instance.state == "running" and instance.tags["Name"] == INSTANCE_NAME:
				if environmentName == None:
					instances.append(instance)
				elif environmentName == instance.tags["env"]:
					instances.append(instance)

	return instances


#
# Function: _getDNSEntriesFromInstances
# Returns an array of fully-qualified DNS names for a set of Amazon 
# instance objects
#
# Author: 
#    Adam Presley
#
def _getDNSEntriesFromInstances(instances):
	results = [x.public_dns_name for x in instances]
	return results


#
# Function: _gitReset
# Resets any local changes to the code repository on the target
# host.
#
# Author: 
#    Adam Presley
#
def _gitReset():
	print ""
	print yellow("Resetting repository...")
	run("cd %s && git checkout -f" % env.deploy_root)


#
# Function: _gitPull
# Pulls most recent changes from the remote origin to the local
# repository on the target host.
#
# Author: 
#    Adam Presley
#
def _gitPull():
	print ""
	print yellow("Updating code...")
	run("cd %s && git pull %s %s" % (env.deploy_root, env.remoteOrigin, env.remoteBranch))


#
# Function: _bundle
# Runs the bundle/minify script (bundle.py) on the target
# host.
#
# Author: 
#    Adam Presley
#
def _bundle():
	print ""
	print yellow("Bundling...")
	run("cd %s/bin && python ./bundle.py" % env.deploy_root)



#####################################################################
# ENVIRONMENTS
#####################################################################

#
# Function: production
# Sets the environment information to those of "production". This is used
# by the methods that get Amazon instance information.
#
# Author: 
#    Adam Presley
#
def production():
	env.user = "ubuntu"
	env.environmentName = "prod"
	env.user = "ubuntu"


#
# Function: test
# Sets the environment information to those of "test". This is used
# by the methods that get Amazon instance information.
#
# Author: 
#    Adam Presley
#
def test():
	env.user = "ubuntu"
	env.environmentName = "test"
	env.user = "ubuntu"


#
# Function: amazon
# Calls methods to get matching Amazon instances based on environment
# criteria. This will set the "hosts" environment variable used
# by all tasks in this deploy script.
#
# Author: 
#    Adam Presley
#
def amazon():
	#
	# Get the DNS addresses for all the instances on Amazon
	#
	env.hosts = _getDNSEntriesFromInstances(_getInstances())
	return env.hosts


#####################################################################
# ACTIONS/TASKS
#####################################################################

#
# Function: updateServers
# Resets and pulls latest code from the origin remote repository down to
# the local repo on all target hosts. It then bundles/minifies JavaScript
# and CSS.
#
# Author: 
#    Adam Presley
#
def updateServers():
	require("hosts", provided_by = [ amazon ])
	require("environmentName", provided_by = [ production, test ])

	print ""
	print green("** Updating Servers for '%s' **" % env.environmentName)

	print DEPLOY_ROOT

	env.deploy_root = DEPLOY_ROOT
	env.remoteOrigin = REPO_REMOTE_ORIGIN
	env.remoteBranch = REPO_REMOTE_BRANCH

	print yellow("%s at %s/%s" % (DEPLOY_ROOT, REPO_REMOTE_ORIGIN, REPO_REMOTE_BRANCH))

	_gitReset()
	_gitPull()
	_bundle()
