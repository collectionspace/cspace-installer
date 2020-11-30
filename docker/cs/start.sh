#!/bin/bash

if [ "$S3_BINARY_MANAGER_ENABLED" = "true" ]; then
  sed -i 's|blob.binary.DefaultBinaryManager|storage.sql.S3BinaryManager|g' \
    $CSPACE_JEESERVER_HOME/cspace/config/services/proto-repo-config.xml

  # update properties
  set +H;

  sed -i "s|!S3_BINARY_MANAGER_ID!|$S3_BINARY_MANAGER_ID|g" \
    $CSPACE_JEESERVER_HOME/nuxeo-server/config/s3binarymanager.properties

  sed -i "s|!S3_BINARY_MANAGER_SECRET!|$S3_BINARY_MANAGER_SECRET|g" \
    $CSPACE_JEESERVER_HOME/nuxeo-server/config/s3binarymanager.properties

  sed -i "s/!S3_BINARY_MANAGER_REGION!/$S3_BINARY_MANAGER_REGION/g" \
    $CSPACE_JEESERVER_HOME/nuxeo-server/config/s3binarymanager.properties

  sed -i "s/!S3_BINARY_MANAGER_BUCKET!/$S3_BINARY_MANAGER_BUCKET/g" \
    $CSPACE_JEESERVER_HOME/nuxeo-server/config/s3binarymanager.properties
fi

# ELASTICSEARCH
sed -i "s/^elasticsearch.enabled=false/elasticsearch.enabled=true/g" \
  $CSPACE_JEESERVER_HOME/nuxeo-server/config/nuxeo.properties

sed -i "s|http://localhost:9200|http://$ES_HOST|g" \
  $CSPACE_JEESERVER_HOME/cspace/config/services/proto-elasticsearch-config.xml

ant create_db import

exec $CSPACE_JEESERVER_HOME/bin/catalina.sh run
