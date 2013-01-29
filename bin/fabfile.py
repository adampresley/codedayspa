#
# Fabric deployment control script
# Author:
#    Adam Presley
#
# Requisites:
#    * fabric
#    * boto
#    * pycrypto (Windows: http://www.voidspace.org.uk/python/modules.shtml#pycrypto)
#    * Environment variables for boto
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


DEPLOY_ROOT = "/webapps/codedayspa"
REPO = "git://github.com/adampresley/codedayspa.git"
REPO_REMOTE_ORIGIN = "origin"
REPO_REMOTE_BRANCH = "master"

INSTANCE_NAME = "codedayspa"


#####################################################################
# SUPPORTING METHODS
#####################################################################
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

def _getDNSEntriesFromInstances(instances):
	results = [x.public_dns_name for x in instances]
	return results

def _gitClone():
	print ""
	print yellow("Cloning the repo...")
	run("cd %s && git clone %s" % (DEPLOY_ROOT, REPO))


def _gitReset():
	print ""
	print yellow("Resetting repository...")
	run("cd %s && git checkout -f" % env.deploy_root)


def _gitPull():
	print ""
	print yellow("Updating code...")
	run("cd %s && git pull %s %s" % (env.deploy_root, env.remoteOrigin, env.remoteBranch))


def _bundle():
	print ""
	print yellow("Bundling...")
	run("cd %s/bin && python ./bundle.py" % env.deploy_root)



#####################################################################
# ENVIRONMENTS
#####################################################################
def production():
	env.user = "ubuntu"
	env.environmentName = "prod"
	env.user = "ubuntu"


def test():
	env.user = "ubuntu"
	env.environmentName = "test"
	env.user = "ubuntu"


def amazon():
	#
	# Get the DNS addresses for all the instances on Amazon
	#
	env.hosts = _getDNSEntriesFromInstances(_getInstances())
	return env.hosts


#####################################################################
# ACTIONS
#####################################################################
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
