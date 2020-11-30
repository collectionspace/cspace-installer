FROM ubuntu:18.04
MAINTAINER Mark Cooper <mark.cooper@lyrasis.org>
# TENANT ARGS + ENV
ARG CSPACE_CORE_CREATE_DISABLED_OPT
ENV CSPACE_CORE_CREATE_DISABLED_OPT=${CSPACE_CORE_CREATE_DISABLED_OPT}
# --build-arg (s) =)
ARG COLLECTIONSPACE_BRANCH
ARG COLLECTIONSPACE_REPOSITORY
ARG COLLECTIONSPACE_TOMCAT
ARG COLLECTIONSPACE_VERSION
ARG CSPACE_ENV
ARG CSPACE_INSTANCE_ID
ARG GATEWAY_REPOSITORY=https://github.com/collectionspace/cspace-public-gateway.git
ARG GATEWAY_VERSION=1.0.0
# DB
ARG DB_PORT
ARG DB_HOST
ARG DB_CSADMIN_PASSWORD
ARG DB_CSPACE_PASSWORD
ARG DB_NUXEO_PASSWORD
ARG DB_READER_PASSWORD
# ELASTICSEARCH
ARG ES_HOST
# EMAIL
ARG CSPACE_SMTP_EMAIL_HOST_OPT
ARG CSPACE_SMTP_EMAIL_AUTH_DEBUG_OPT
ARG CSPACE_SMTP_EMAIL_AUTH_USERNAME_OPT
ARG CSPACE_SMTP_EMAIL_AUTH_PASSWORD_OPT
# JAVA
ARG ANT_OPTS
ARG CATALINA_OPTS
ARG MAVEN_OPTS
# S3
ARG S3_BINARY_MANAGER_BUCKET
ARG S3_BINARY_MANAGER_ENABLED
ARG S3_BINARY_MANAGER_REGION
ARG S3_BINARY_MANAGER_ID
ARG S3_BINARY_MANAGER_SECRET
ENV ANT_OPTS=${ANT_OPTS} \
    CATALINA_OPTS=${CATALINA_OPTS} \
    MAVEN_OPTS=${MAVEN_OPTS} \
    CATALINA_HOME=/$COLLECTIONSPACE_TOMCAT \
    CATALINA_PID=/$COLLECTIONSPACE_TOMCAT/bin/tomcat.pid \
    COLLECTIONSPACE_APPLICATION=${COLLECTIONSPACE_REPOSITORY}/application.git \
    COLLECTIONSPACE_SERVER=https://s3-us-west-2.amazonaws.com/cs-public-shared-files/releases/$COLLECTIONSPACE_VERSION/cspace-server-${COLLECTIONSPACE_VERSION}.tar.gz \
    COLLECTIONSPACE_SERVICES=${COLLECTIONSPACE_REPOSITORY}/services.git \
    CSPACE_INSTANCE_ID=${CSPACE_INSTANCE_ID} \
    CSPACE_ENV=${CSPACE_ENV} \
    CSPACE_JEESERVER_HOME=/$COLLECTIONSPACE_TOMCAT \
    CSPACE_SMTP_EMAIL_HOST_OPT=${CSPACE_SMTP_EMAIL_HOST_OPT} \
    CSPACE_SMTP_EMAIL_AUTH_DEBUG_OPT=${CSPACE_SMTP_EMAIL_AUTH_DEBUG_OPT} \
    CSPACE_SMTP_EMAIL_AUTH_USERNAME_OPT=${CSPACE_SMTP_EMAIL_AUTH_USERNAME_OPT} \
    CSPACE_SMTP_EMAIL_AUTH_PASSWORD_OPT=${CSPACE_SMTP_EMAIL_AUTH_PASSWORD_OPT} \
    DB_HOST=${DB_HOST} \
    DB_PORT=${DB_PORT} \
    DB_CSADMIN_PASSWORD=${DB_CSADMIN_PASSWORD} \
    DB_CSPACE_PASSWORD=${DB_CSPACE_PASSWORD} \
    DB_NUXEO_PASSWORD=${DB_NUXEO_PASSWORD} \
    DB_READER_PASSWORD=${DB_READER_PASSWORD} \
    ES_HOST=${ES_HOST} \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    JEE_PORT=8180 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    S3_BINARY_MANAGER_BUCKET=${S3_BINARY_MANAGER_BUCKET} \
    S3_BINARY_MANAGER_ENABLED=${S3_BINARY_MANAGER_ENABLED} \
    S3_BINARY_MANAGER_REGION=${S3_BINARY_MANAGER_REGION} \
    S3_BINARY_MANAGER_ID=${S3_BINARY_MANAGER_ID} \
    S3_BINARY_MANAGER_SECRET=${S3_BINARY_MANAGER_SECRET} \
    SPRING_CONFIG_LOCATION=classpath:/gateway.yml
WORKDIR /
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -y install --no-install-recommends \
      ant \
      curl \
      git \
      imagemagick \
      maven \
      openjdk-8-jdk-headless \
      openjdk-8-jre-headless \
      postgresql-client \
      rsync \
      unzip \
      wget && \
      rm -rf /var/lib/apt/lists/* && \
    wget $COLLECTIONSPACE_SERVER && tar -zxvof cspace-server-${COLLECTIONSPACE_VERSION}.tar.gz && \
    git clone -b $COLLECTIONSPACE_BRANCH --single-branch $COLLECTIONSPACE_SERVICES && \
    git clone -b $COLLECTIONSPACE_BRANCH --single-branch $COLLECTIONSPACE_APPLICATION && \
    git clone $GATEWAY_REPOSITORY && \
    groupadd -g 1000 collectionspace && \
    useradd  -u 1000 -g collectionspace collectionspace && \
    mkdir /home/collectionspace && \
    chown -R collectionspace:collectionspace /home/collectionspace /services /application /cspace-public-gateway $CSPACE_JEESERVER_HOME
USER collectionspace
# ADD TENANTS TO THE SERVICES AND APP LAYER
WORKDIR /services
RUN mvn clean install -DskipTests --quiet
WORKDIR /application
RUN mvn clean install -DskipTests --quiet
WORKDIR /cspace-public-gateway
RUN mvn clean package --quiet -Dpackaging=war
WORKDIR /services
RUN ant undeploy deploy
# UPDATE THE APACHE DIST INCLUDING ADDING TENANT UIs
ADD --chown=collectionspace:collectionspace \
    setenv.sh $CSPACE_JEESERVER_HOME/bin/setenv.sh
ADD --chown=collectionspace:collectionspace \
    s3binarymanager.properties $CSPACE_JEESERVER_HOME/nuxeo-server/config/s3binarymanager.properties
ADD --chown=collectionspace:collectionspace \
    index.html $CSPACE_JEESERVER_HOME/webapps/ROOT/index.html
ADD --chown=collectionspace:collectionspace \
    *.sh /
# GATEWAY
ADD --chown=collectionspace:collectionspace \
    gateway.yml $CSPACE_JEESERVER_HOME/lib/gateway.yml
RUN mv /cspace-public-gateway/target/org.collectionspace.publicbrowser-${GATEWAY_VERSION}-SNAPSHOT.war \
    $CSPACE_JEESERVER_HOME/webapps/gateway.war
# ADD STARTUP SCRIPTS AND SOME CLEANUP
RUN chmod u+x /*.sh && \
    chmod u+x $CSPACE_JEESERVER_HOME/bin/*.sh && \
    rm -rf $CSPACE_JEESERVER_HOME/webapps/host-manager && \
    rm -rf $CSPACE_JEESERVER_HOME/webapps/manager
CMD ["/start.sh"]
