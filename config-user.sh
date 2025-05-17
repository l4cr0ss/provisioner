#!/bin/bash
# Create a new user with a home directory and no password.
# Author: l4cr0ss

config_user()
{
	if [[ -z "$1" ]]; then # Bail out without a username
		echo "ERROR: No user specified for configuration (hint: --user)."
		exit 1
	fi
	id -u "$1" 
	if [[ "$?" -eq 1 ]]; then
		useradd "-m" "-s" "/bin/bash" "$1"
	fi
}
