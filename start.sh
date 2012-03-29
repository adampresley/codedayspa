#!/bin/bash

#
# Start MongoDB
#
#server/mongodb/mongod --fork -f server/mongodb/config


#
# Start Tomcat
#
server/tomcat/bin/catalina.sh run

#
# Stop MongoDB
#
#kill -2 `pidof mongod`
