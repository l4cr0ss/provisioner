#!/bin/bash
# Install global vimrc file
# Author: Jefferson Hudson

# Assumptions:
#   1. The file server hosts a vim configuration in the expected location.

config_vim()
{
	# Install vim if it isn't present
	apt-get "install" "-y" "vim"

	wget "$SERVER/configs/vim/vimrc" \
		-O "/etc/vim/vimrc"
}
