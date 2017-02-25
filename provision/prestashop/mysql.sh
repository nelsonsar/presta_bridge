#!/bin/bash

# Installs the MySQL binaries and set the root password to "abc123"
# in order to make SQL scripting easier.
function install_mysql() {
    sudo debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password password abc123"
    sudo debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password_again password abc123"
    sudo apt-get -y install mysql-server-5.6
}
