# PrestaBridge

A bridge between Prestashop and a comfortable product administration.

## How it works

PrestaBridge is a Rails application to help you manage your products. After you create your account you can create a store by adding a name to it, the shop URL and an API key so PrestaBridge can access your Prestashop installation.

## Development setup

All provisioning scripts are located in the provision folder. There are two machines being provisioned: prestashop and presta_bridge. The first one is a PrestaShop installation and the latter one is a Rails app that will consume the PrestaShop API.

For both cases the main script, which triggers the whole installation, is named setup.sh and both of them includes more scripts to install or configure a specific binary or library.

For prestashop we have the following provisioning scripts:

* apache.sh: Configures Apache Web Server to serve PrestaShop
* composer.sh: Install Composer following the instructions in the website
* mysql.sh: Installs MySQL binary and defines root password as "abc123"
* php.sh: Install PHP 5 and all extensions to run PrestaShop
* prestashop.sh: This script automates the installation of the PrestaShop store avoiding any interaction with a web browser

And for presta_bridge machine we have the following scripts:

* bundler.sh: Which installs bundler gem and run bundle install
* postgresql.sh: Which installs PostgreSQL 9.6 packages and creates a user for vagrant
* rvm.sh: Which installs and configure RVM with Ruby 2.4.0

The two VMs are instances of Ubuntu 14.04 LTS instance because of the ease of installing and configuring packages. Also, both machines will use 1GB of
memory.

For presta_bridge (Rails app) NFS to speed up I/O writes so your password will be required.

To access presta_bridge on your host machine go to http://localhost:8081 and run all rails related command on the guest machine (rails c, rake db:migrate, etc).

The PrestaShop installation is available on http://10.0.0.10 and to access the admin panel use the following credentials:

username: pub@prestashop.com
password: 0123456789

You will need to access it in order to create an API key. For further details please refer to the files in the `provision` dir.

## Running tests

`$ rspec spec/` after the machine provision.

## Deploy gotcha

Since the project structure is a bit different from an usual Rails application to deploy it to Heroku you will need to run:

`git subtree push --prefix presta_bridge heroku master`

## Next steps

* Remove frontend duplication using partials (there a lot of job to be done here...)
* Add more information to user when something goes wrong, for example, when credentials are wrong
* Make contract tests for Prestashop API to avoid surprises if it changes
* Add the project to TravisCI to make sure everything is working after changing some code
* Create a better wrapper for the `prestashop` gem since it's pretty hard to work with
* Add more information in product creation page so users will be able to chose suppliers, categories and upload photos
* Enable Heroku automatic deploys
