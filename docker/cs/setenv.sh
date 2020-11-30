#!/bin/sh
# REMOVED CATALINA_OPTS (XMX etc.)
echo Setting NUXEO_HOME
export NUXEO_HOME="$CATALINA_BASE/nuxeo-server"
echo Setting JAVA_OPTS
export JAVA_OPTS="$JAVA_OPTS -javaagent:$CATALINA_BASE/lib/spring-instrument-4.3.1.RELEASE.jar -Dslf4j.detectLoggerNameMismatch=true -Dlog4j.debug=false -Dnuxeo.home.dir=$NUXEO_HOME -Dnuxeo.log.dir=$NUXEO_HOME/log -Dorg.collectionspace.services.authorities.reset=true"
