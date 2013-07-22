#
# Start Tomcat
#
echo "Starting Tomcat on port 8091..."
echo ""

export CATALINA_HOME="./server/tomcat"
server/tomcat/bin/catalina.sh run
