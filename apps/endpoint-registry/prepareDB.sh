#!/bin/bash

echo "Executing script to prepare a clean registry database."

#read -p "Enter path to SQL dumps (generated by emob-backup-user, without trailing slash): " path_to_sql_dumps
#path_to_sql_dumps=$1

echo "host: $ENDPOINT_REGISTRY_POSTGRES_HOST"
echo "port: $ENDPOINT_REGISTRY_POSTGRES_PORT"
echo "db: $ENDPOINT_REGISTRY_POSTGRES_DB"
echo "user: $ENDPOINT_REGISTRY_POSTGRES_USER"
#echo "pw: $ENDPOINT_REGISTRY_POSTGRES_PASSWORD"

#echo "Prepare .pgpass"

#sed -i "s/PW-PLACEHOLDER/${ENDPOINT_REGISTRY_POSTGRES_PASSWORD}/g" .pgpass
#PGPASSFILE="~/registry/.pgpass"

echo "Dropping existing database tables..."

PGPASSWORD=$ENDPOINT_REGISTRY_POSTGRES_PASSWORD dropdb -h $ENDPOINT_REGISTRY_POSTGRES_HOST -p $ENDPOINT_REGISTRY_POSTGRES_PORT -U $ENDPOINT_REGISTRY_POSTGRES_USER -w -e $ENDPOINT_REGISTRY_POSTGRES_DB

echo "Create database new..."

#PGPASSWORD=$ENDPOINT_REGISTRY_POSTGRES_PASSWORD psql -h $ENDPOINT_REGISTRY_POSTGRES_HOST -p $ENDPOINT_REGISTRY_POSTGRES_PORT -U $ENDPOINT_REGISTRY_POSTGRES_USER -d $ENDPOINT_REGISTRY_POSTGRES_DB create_database.sql
PGPASSWORD=$ENDPOINT_REGISTRY_POSTGRES_PASSWORD createdb -h $ENDPOINT_REGISTRY_POSTGRES_HOST -p $ENDPOINT_REGISTRY_POSTGRES_PORT -U $ENDPOINT_REGISTRY_POSTGRES_USER -w -e --tablespace=pg_default --encoding='UTF8' --lc-collate='en_US.utf8' --lc-ctype='en_US.utf8' $ENDPOINT_REGISTRY_POSTGRES_DB

echo "Create tables"

PGPASSWORD=$ENDPOINT_REGISTRY_POSTGRES_PASSWORD psql -h $ENDPOINT_REGISTRY_POSTGRES_HOST -p $ENDPOINT_REGISTRY_POSTGRES_PORT -U $ENDPOINT_REGISTRY_POSTGRES_USER -d $ENDPOINT_REGISTRY_POSTGRES_DB -w -e -f sql/create_assets.sql
PGPASSWORD=$ENDPOINT_REGISTRY_POSTGRES_PASSWORD psql -h $ENDPOINT_REGISTRY_POSTGRES_HOST -p $ENDPOINT_REGISTRY_POSTGRES_PORT -U $ENDPOINT_REGISTRY_POSTGRES_USER -d $ENDPOINT_REGISTRY_POSTGRES_DB -w -e -f sql/create_asset_administration_shells.sql
PGPASSWORD=$ENDPOINT_REGISTRY_POSTGRES_PASSWORD psql -h $ENDPOINT_REGISTRY_POSTGRES_HOST -p $ENDPOINT_REGISTRY_POSTGRES_PORT -U $ENDPOINT_REGISTRY_POSTGRES_USER -d $ENDPOINT_REGISTRY_POSTGRES_DB -w -e -f sql/create_endpoints.sql
PGPASSWORD=$ENDPOINT_REGISTRY_POSTGRES_PASSWORD psql -h $ENDPOINT_REGISTRY_POSTGRES_HOST -p $ENDPOINT_REGISTRY_POSTGRES_PORT -U $ENDPOINT_REGISTRY_POSTGRES_USER -d $ENDPOINT_REGISTRY_POSTGRES_DB -w -e -f sql/create_semantic_protocols.sql
PGPASSWORD=$ENDPOINT_REGISTRY_POSTGRES_PASSWORD psql -h $ENDPOINT_REGISTRY_POSTGRES_HOST -p $ENDPOINT_REGISTRY_POSTGRES_PORT -U $ENDPOINT_REGISTRY_POSTGRES_USER -d $ENDPOINT_REGISTRY_POSTGRES_DB -w -e -f sql/create_roles.sql
PGPASSWORD=$ENDPOINT_REGISTRY_POSTGRES_PASSWORD psql -h $ENDPOINT_REGISTRY_POSTGRES_HOST -p $ENDPOINT_REGISTRY_POSTGRES_PORT -U $ENDPOINT_REGISTRY_POSTGRES_USER -d $ENDPOINT_REGISTRY_POSTGRES_DB -w -e -f sql/create_aas_role.sql
