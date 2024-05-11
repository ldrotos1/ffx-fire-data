# ffx-fire-data
Data management code for a Fairfax County Fire and Rescue operations management application. This repository consists of bash scripts that are used to create and load data into a Postgres database used by the applicaiton.

## Requirements
Postgres 16,
PSQL 16,
PostGIS

## Setup
### Set environment variables
PGPASSFILE = ~/ffx-fire-ops/.pgpass <br/>
This will allow scripts to automatically authenticate to the postgres database once the file is created

## Scripts
### set_conn_props.sh
Prompts the user for database server connection information and saves that information to the user’s local profile in a couple of configuration files. Other scripts use the configuration files to automatically connect to the database server.

### create_database.sh
Connects to the database server and creates the database, schema, and loads all the required application data.

### delete_database.sh
Connects to the database server and deletes the application’s database.
