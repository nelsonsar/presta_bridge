function install_bundler {
    sudo apt-get install nodejs -y
    (cd /presta_bridge; gem install bundler; bundle install)
}
