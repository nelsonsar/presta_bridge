#!/bin/bash

# Main function of this file. It will invoke all needed functions
# to install PrestaShop via command line.
function install_prestashop() {
    install_prestashop_installer && \
        export_installer_to_local_bin && \
        download_prestashop && \
        create_database && \
        run_installer && \
        delete_install_folder
}

# Installs the prestashop cli installer via composer
function install_prestashop_installer() {
    php composer.phar global require --prefer-stable "gskema/prestashop-installer=~2.0"
}

# Exports the prestashop cli installer to /usr/local/bin so
# it's available to be used without referecing its full path and
# without messing with the $PATH variable
function export_installer_to_local_bin() {
    ln -s ~/.config/composer/vendor/bin/prestashop /usr/local/bin/prestashop
}

# Uses the prestashop cli installer to install PrestaShop 1.6.1.3 with
# Star Wars products
function download_prestashop() {
    cd /var/www/prestashop && \
        prestashop new --release="1.6.1.3" --fixture="starwars"
}

# Creates PrestaShop database named "prestashop"
function create_database() {
    mysql -uroot -pabc123 -e "CREATE DATABASE prestashop;"
}

# Runs PrestaShop built-in installer.
#
# This function will define the configurations used by the PrestaShop instance
# like the domain (note that we need to put the port used or redirects would fail),
# the db user is "root" and the password is "abc123" (the one defined in mysql.sh).
function run_installer() {
    cd /var/www/prestashop/install && \
        php index_cli.php --domain="10.0.0.10" --db_clear=1 --db_create=1 --db_password="abc123"
}

# Deletes the "install" folder from PrestaShop to avoid security issues
# and be able to access the admin panel.
function delete_install_folder() {
    cd /var/www/prestashop && rm -rf /var/www/prestashop/install
}
