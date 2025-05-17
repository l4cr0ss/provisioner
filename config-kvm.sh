#!/bin/bash
# Download and configure KVM
# Author: l4cr0ss

# Assumptions:
#   1. Machine being provisioned runs Ubuntu 16.04 and has stated packges available in 
#       the apt repository.

config_kvm()
{
	apt-get "install" "-y" "qemu-kvm" "libvirt-bin" "ubuntu-vm-builder" "bridge-utils"
	if [[ $? != 0 ]];
	then
		echo "ERROR: Failed to install kvm deps, aborting"
	fi
}
