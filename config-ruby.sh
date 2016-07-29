#!/bin/bash
# Install Ruby using rbenv
# Author: Jefferson Hudson

# Parameters:
#	$1 == The version of Ruby to install (e.g. "2.3.1")
#	$2 == The user to install Ruby for
#
# Assumptions:
#	1. rbenv is installed for the specified user

config_ruby()
{
	if [[ -z $1 ]]; then # Bail out if the ruby version hasn't been specified
		echo 'ERROR: Must specify version of ruby to install (hint: --ruby-version).'
		exit 1
	elif [[ -z $2 ]]; then # ..Or if the rbenv user hasn't been specified
		echo 'ERROR: Must specify user to install with (hint: --rbenv-user).'
		exit 1
	fi

	# Check for and install system dependencies
	apt-get "install" "-y" "autoconf" "bison" "build-essential" "libssl-dev" \
		"libyaml-dev" "libreadline6-dev" "zlib1g-dev" "libncurses5-dev" \
		"libffi-dev" "libgdbm3" "libgdbm-dev"

	rbenv_user=$2
	ruby_version=$1
	# Install Ruby and set it to be the default interpreter
	su - $rbenv_user -c "./.rbenv/bin/rbenv install $ruby_version"
	su - $rbenv_user -c "./.rbenv/bin/rbenv global $ruby_version"
}
