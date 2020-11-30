#!/bin/bash

echo ">>> CREATING CSADMIN"
psql --username postgres <<- EOSQL
  CREATE ROLE csadmin CREATEDB CREATEROLE INHERIT LOGIN PASSWORD '$DB_CSADMIN_PASSWORD';
EOSQL
echo ""
echo ">>> COMPLETED"
