#!/bin/bash

# Add prestashop.conf file and enables it as a host
#
# The php5 package already installs apache2 by default on Ubuntu. But,
# apache2 comes with a pre-configured virtual host that has the highest priority
# over other configuration files.
#
# This function will copy the configuration file for PrestaShop (prestashop.conf)
# to sites-available Apache's folder, make a symlink of it in sites-enabled folder,
# remove the default config file from Apache and finally restart it. After calling this
# function Apache is ready to serve PrestaShop.

function configure_apache() {
    cp /tmp/prestashop/prestashop.conf /etc/apache2/sites-available/ && \
        ln -s /etc/apache2/sites-available/prestashop.conf /etc/apache2/sites-enabled/prestashop.conf && \
        rm /etc/apache2/sites-available/000-default.conf && \
        rm /etc/apache2/sites-enabled/000-default.conf && \
        service apache2 restart
}
