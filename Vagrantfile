# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define :prestashop do |prestashop|
    prestashop.vm.box = "ubuntu/trusty64"
    prestashop.vm.network "private_network", ip: "10.0.0.10"

    prestashop.vm.synced_folder "./prestashop", "/var/www/prestashop",
      owner: "vagrant",
      group: "www-data",
      mount_options: ["dmode=775,fmode=664"],
      create: true

    prestashop.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end

    prestashop.vm.provision "file", source: "provision/prestashop/mysql.sh",        destination: "/tmp/prestashop/mysql.sh"
    prestashop.vm.provision "file", source: "provision/prestashop/php.sh",          destination: "/tmp/prestashop/php.sh"
    prestashop.vm.provision "file", source: "provision/prestashop/composer.sh",     destination: "/tmp/prestashop/composer.sh"
    prestashop.vm.provision "file", source: "provision/prestashop/prestashop.sh",   destination: "/tmp/prestashop/prestashop.sh"
    prestashop.vm.provision "file", source: "provision/prestashop/apache.sh",       destination: "/tmp/prestashop/apache.sh"
    prestashop.vm.provision "file", source: "provision/prestashop/prestashop.conf", destination: "/tmp/prestashop/prestashop.conf"

    prestashop.vm.provision "shell", path: "provision/prestashop/setup.sh"
  end

  config.vm.define :presta_bridge do |rails|
    rails.vm.box = "ubuntu/trusty64"
    rails.vm.network "forwarded_port", guest: 3000, host: 8081
    rails.vm.network "private_network", ip: "10.0.0.11"
    rails.vm.synced_folder "./presta_bridge", "/presta_bridge", nfs: true

    rails.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end

    rails.vm.provision "file", source: "provision/rails/rvm.sh",        destination: "/tmp/rails/rvm.sh"
    rails.vm.provision "file", source: "provision/rails/postgresql.sh", destination: "/tmp/rails/postgresql.sh"
    rails.vm.provision "file", source: "provision/rails/bundler.sh",    destination: "/tmp/rails/bundler.sh"

    rails.vm.provision "shell", path: "provision/rails/setup.sh"
  end
end
