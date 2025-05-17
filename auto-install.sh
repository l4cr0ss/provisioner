#!/bin/bash
# Script framework for virtual machine provisioning.
# Author: l4cr0ss

#---------------------------#
# Function defs and imports #
#---------------------------#

SERVER=""

authorized_keys(){
	wget "$SERVER"/scripts/config-authorized_keys.sh \
		-O /tmp/config-authorized_keys.sh
	source /tmp/config-authorized_keys.sh
	rm /tmp/config-authorized_keys.sh
	config_authorized_keys;
}

kvm()
{
	wget "$SERVER"/scripts/config-kvm.sh \
		-O /tmp/config-kvm.sh
	source /tmp/config-kvm.sh
	rm /tmp/config-kvm.sh
	config_kvm;
}

nginx(){
	wget "$SERVER"/scripts/config-nginx.sh \
		-O /tmp/config-nginx.sh
	source /tmp/config-nginx.sh
	rm /tmp/config-nginx.sh
	config_nginx;
}

pgsql(){
	wget "$SERVER"/scripts/config-pgsql.sh \
		-O /tmp/config-pgsql.sh
	source /tmp/config-pgsql.sh
	rm /tmp/config-pgsql.sh
	config_pgsql $1;
}

queue() {
	wget "$SERVER"/dstructs/queue.sh \
		-O /tmp/queue.sh
	source /tmp/queue.sh
	rm /tmp/queue.sh
}

rbenv(){
	wget "$SERVER"/scripts/config-rbenv.sh \
		-O /tmp/config-rbenv.sh
	source /tmp/config-rbenv.sh
	rm /tmp/config-rbenv.sh
	config_rbenv $1;
}

ruby(){
	wget "$SERVER"/scripts/config-ruby.sh \
		-O /tmp/config-ruby.sh
	source /tmp/config-ruby.sh
	rm /tmp/config-ruby.sh
	config_ruby $1 $2;
}

sshd(){
	wget "$SERVER"/scripts/config-sshd.sh \
		-O /tmp/config-sshd.sh
	source /tmp/config-sshd.sh
	rm /tmp/config-sshd.sh
	config_sshd;
}

user(){
	wget "$SERVER"/scripts/config-user.sh \
		-O /tmp/config-user.sh
	source /tmp/config-user.sh
	rm /tmp/config-user.sh
	config_user $1;
}

vim(){
	wget "$SERVER"/scripts/config-vim.sh \
		-O /tmp/config-vim.sh
	source /tmp/config-vim.sh
	rm /tmp/config-vim.sh
	config_vim;
}

# ----------------
# Package configs
# ----------------
pgsql_server()
{
	vim;
	sshd;
	pgsql "9.5";
}

hypervisor()
{
	vim;
	sshd;
	kvm;
}

server()
{
	vim;
	sshd;
}

# ------------ #
# Script Entry #
# ------------ #
# Test if user executing the script has root privileges
if [[ "$(id -u)" != "0" ]]; 
then
	exit 1
fi
queue;

# Parse commandline options
while :; do
	case $1 in 
		-d|--do-config)
			if [[ -n "$2" ]]; then
                # Push the item onto the queue
				push $2 
			else
				echo 'ERROR: "--do-config" requires a non-empty option argument.'
				exit 1
			fi
			;;

		--) # End of all options.
			shift
			break
			;;

		-?*)
			printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
			;;

		*) # Default case: If no more options then break the loop.
			break
	esac
	shift
done

while :; do
	pop
	if [[ -z "$D" ]]; then # Nothing left on queue
		break
	else
		eval ${D}
	fi
done

