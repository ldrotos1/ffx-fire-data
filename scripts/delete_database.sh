#!/bin/bash
echo "|-------------------------------------------------------------------|"
echo "| This script will delete the ffx fire operations postgres database |"
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

if ! [ ${#conn_info[@]} = 4 ]; then
  printf "\nThe ~/ffx-fire-ops/.dbconnprops file is corrupted"
  printf "\nRun set_conn_props.sh to recreate"
  exit 1
fi

host=${conn_info[0]}
port=${conn_info[1]}
user=${conn_info[3]}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SQL_DIR="${SCRIPT_DIR}/delete_database.sql"
psql -U "$user" -h "$host" -p "$port" -f "$SQL_DIR"

echo "Database deleted"