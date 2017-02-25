#!/bin/bash

php_packages=(php5 php5-curl php5-cli php5-mysql php5-gd php5-mcrypt php5-memcache)

function install_php() {
    for package in ${php_packages[@]}; do
        sudo apt-get -y install $package
    done
}
