#!/bin/bash


# Include section
#
# The files listed above will be uploaded to the guest machine
# and live inside the /tmp folder.

# RVM installation functions
source "/tmp/rails/rvm.sh"
# PostgreSQL 9.6 installation functions
source "/tmp/rails/postgresql.sh"
# Bundler gem installation and bundle install command
source "/tmp/rails/bundler.sh"


function adjust_locales {
    sudo locale-gen en_US en_US.UTF-8
    sudo dpkg-reconfigure locales
}

function update_apt {
    sudo apt-get update
}

is_rvm_installed=$(which rvm)

# Here we assume that if we don't have RVM we didn't provision anything...
if [ "$is_rvm_installed" == "" ]; then
    update_apt && adjust_locales && install_rvm && install_postgresql 

    installation_result=$(type rvm | head -1)
    if [ "$installation_result" == "rvm is a function" ]; then
        # If RVM was successfully installed we can use bundler
        install_bundler
        echo "===> Setup completed!"
    else
        echo "===> Something went wrong..."
    fi
fi

