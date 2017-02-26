function install_postgresql {
    echo "===> Installing PostgreSQL"
    add_postgresql_apt_repository && \
        sudo apt-get update && \
        sudo apt-get install postgresql postgresql-contrib -y && \
        sudo apt-get install libpq-dev -y && \
        create_database_user
}

function add_postgresql_apt_repository {
    echo "===> Adding PostgreSQL APT repository"
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
    wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
}

function create_database_user {
    sudo -H -u postgres bash -c 'createuser --no-password vagrant'
}

