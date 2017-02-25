#!/bin/bash

# Include section
#
# The files listed above will be uploaded to the guest machine
# and live inside the /tmp folder.

# MySQL related functions
source "/tmp/prestashop/mysql.sh"
# PHP related functions
source "/tmp/prestashop/php.sh"
# Composer installation
source "/tmp/prestashop/composer.sh"
# PrestaShop automated installation functions
source "/tmp/prestashop/prestashop.sh"
# Apache configuration
source "/tmp/prestashop/apache.sh"


# Needed since the guest machine is created from scratch by Vagrant
# without doing this is impossible to install any package
function update_apt {
    sudo apt-get update
}

# Provisioning steps:
# 1. Update apt repositories
# 2. Install MySQL binaries and configure root password
# 3. Install PHP and needed extensions
# 4. Install Composer
# 5. Install PrestaShop via console using instal/index_cli.php
# 6. Configure Apache (a very basic config) to serve PrestaShop
update_apt && \
    install_mysql && \
    install_php && \
    install_composer && \
    install_prestashop && \
    configure_apache
