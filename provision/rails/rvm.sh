function install_rvm {
    add_gpg_key && \
        download_rvm && \
        add_user_to_rvm_group && \
        rvm_start
}

function add_gpg_key {
    echo "===> Adding RVM GPG Key"
    sudo apt-get update
    sudo apt-get install gnupg2 -y
    gpg2 --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
}

function download_rvm {
    echo "===> Installing RVM"
    curl -sSL https://get.rvm.io | bash -s stable --ruby
}

function add_user_to_rvm_group {
    sudo usermod -a -G rvm vagrant
}

function rvm_start {
    source /usr/local/rvm/scripts/rvm
}

