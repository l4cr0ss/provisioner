#!/bin/bash
# Install Postgresql along with prebuilt configuration files
# Author: Jefferson Hudson

# Parameters:
#   $1 == The version of Postgresql to install (e.g. "9.5")

# Assumptions:
#   1. The file server hosts `pg_hba.conf` and `postgresql.conf` for the 
#       requested version of pgsql and in a hierarchy like: 
#       '../configs/master/$1/*.conf'

config_pgsql()
{
	# Bail out if the pgsql version hasn't been specified
	if [[ -z "$1" ]]; then
		echo 'ERROR: Must specify version of pgsql to install (hint: --pg-version).'
		exit 15
	else 
		pgv="$1"
	fi 

	# Install postgresql of the specified version
	apt-get "install" "-y" "postgresql-$pgv" "postgresql-contrib" \
		"libpq-dev" "postgresql-common" "postgresql-server-dev-$pgv"

	wget "$SERVER/configs/postgresql/master/$pgv/pg_hba.conf" \
		 -O "/etc/postgresql/${pgv}/main/pg_hba.conf"
	wget "$SERVER/configs/postgresql/master/$pgv/postgresql.conf" \
		 -O "/etc/postgresql/${pgv}/main/postgresql.conf"

	service "postgresql" "restart"
}       
