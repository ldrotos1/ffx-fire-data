#!/bin/bash
echo "|-------------------------------------------------------------------|"
echo "| This script will create the ffx fire operations postgres database |"
echo "|-------------------------------------------------------------------|"

if ! [ -f ~/ffx-fire-ops/.dbconnprops ]; then
  printf "\nRequired ~/ffx-fire-ops/.dbconnprops file doesn't exist"
  printf "\nRun set_conn_props.sh to create"
  exit 1
fi

if ! [ -f ~/ffx-fire-ops/.pgpass ]; then
  printf "\nRequired ~/ffx-fire-ops/.pgpass file doesn't exist"
  printf "\nRun set_conn_props.sh to create"
  exit 1
fi

IFS=":"
read -ra conn_info < ~/ffx-fire-ops/.dbconnprops

if ! [ ${#conn_info[@]} = 3 ]; then
  printf "\nThe ~/ffx-fire-ops/.dbconnprops file is corrupted"
  printf "\nRun set_conn_props.sh to recreate"
  exit 1
fi

host=${conn_info[0]}
port=${conn_info[1]}
user=${conn_info[2]}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CREATE_DB_FILE="${SCRIPT_DIR}/sql/create_database.sql"
CREATE_TABLES_FILE="${SCRIPT_DIR}/sql/create_table_schema.sql"
LOAD_DATA_FILE="${SCRIPT_DIR}/data/depart_data.csv"

LOAD_DATA_FILE=$(echo "$LOAD_DATA_FILE" | tr / \\\\)
LOAD_DATA_FILE="c:$(echo "$LOAD_DATA_FILE" | cut -c 3-)"

psql -U "$user" -h "$host" -p "$port" -f "$CREATE_DB_FILE"
psql -U "$user" -h "$host" -p "$port" -d ffx-fire-ops -f "$CREATE_TABLES_FILE"

psql -U "$user" -h "$host" -p "$port" -d ffx-fire-ops \
  -c "\\copy ffx_fire_ops.department from '$LOAD_DATA_FILE' WITH DELIMITER '|' CSV;"

echo "Database created"