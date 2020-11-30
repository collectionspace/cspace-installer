#!/bin/bash

# RDS COMPATIBLE USER AND DB SETUP
echo ">>> CREATING USERS AND DB"
PGPASSWORD=${DB_CSADMIN_PASSWORD} psql --host $DB_HOST --username csadmin template1 <<- EOSQL
  CREATE ROLE cspace${CSPACE_INSTANCE_ID} WITH PASSWORD '${DB_CSPACE_PASSWORD}' LOGIN;
  CREATE ROLE nuxeo${CSPACE_INSTANCE_ID}  WITH PASSWORD '${DB_NUXEO_PASSWORD}'  LOGIN;
  CREATE ROLE reader${CSPACE_INSTANCE_ID} WITH PASSWORD '${DB_READER_PASSWORD}' LOGIN;

  GRANT cspace${CSPACE_INSTANCE_ID} TO csadmin;
  GRANT nuxeo${CSPACE_INSTANCE_ID}  TO csadmin;
  GRANT reader${CSPACE_INSTANCE_ID} TO csadmin;

  CREATE DATABASE cspace${CSPACE_INSTANCE_ID} ENCODING 'UTF8' OWNER cspace${CSPACE_INSTANCE_ID};
  CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
EOSQL
echo ""
echo ">>> COMPLETED"

# PREVENT CSPACE FROM DELETING / DROPPING WHAT WE SETUP
find $CSPACE_JEESERVER_HOME/cspace/services/db/postgresql/ \
  -type f | xargs sed -i -e '/CREATE DATABASE/Id'

find $CSPACE_JEESERVER_HOME/cspace/services/db/postgresql/ \
  -type f | xargs sed -i -e '/CREATE ROLE/Id'

find $CSPACE_JEESERVER_HOME/cspace/services/db/postgresql/ \
  -type f | xargs sed -i -e '/DELETE/Id'

find $CSPACE_JEESERVER_HOME/cspace/services/db/postgresql/ \
  -type f | xargs sed -i -e '/DROP/Id'

# TODO: CAN REMOVE WHEN ALL CSPACE v5.3
# https://github.com/collectionspace/services/commit/634202d433957146385d7a0ae84cc5fa66665423
find $CSPACE_JEESERVER_HOME/cspace/services/db/postgresql/ \
  -type f | xargs sed -i -e '/CREATE INDEX IF NOT EXISTS/b; s/CREATE INDEX/CREATE INDEX IF NOT EXISTS/Ig'

find $CSPACE_JEESERVER_HOME/cspace/services/db/postgresql/ \
  -type f | xargs sed -i -e '/CREATE SEQUENCE IF NOT EXISTS/b; s/CREATE SEQUENCE/CREATE SEQUENCE IF NOT EXISTS/Ig'

find $CSPACE_JEESERVER_HOME/cspace/services/db/postgresql/ \
  -type f | xargs sed -i -e '/CREATE TABLE IF NOT EXISTS/b; s/CREATE TABLE/CREATE TABLE IF NOT EXISTS/Ig'

cd /services && ant create_db -Drecreate_db=true import
