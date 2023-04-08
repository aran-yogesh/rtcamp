#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Installing Docker..."
    # Install Docker
    # ...
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null
then
    echo "docker-compose is not installed. Installing docker-compose..."
    # Install docker-compose
    # ...
    sudo apt-get install pip
    sudo pip install docker-compose
fi

# Get the site name from the command-line argument
if [ $# -eq 0 ]
then
    echo "Usage: $0 <site-name>"
    exit 1
fi
SITE_NAME=$1

# Create the docker-compose file for the WordPress site
cat << EOF > docker-compose.yml
version: '3'
services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example_root_password
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: example_password
  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - "8000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: example_password
      WORDPRESS_DB_NAME: wordpress
volumes:
  db_data:
EOF

# Create the /etc/hosts entry for the site
echo "127.0.0.1    $SITE_NAME" | sudo tee -a /etc/hosts

# Enable the site
function enable_site() {
    echo "Enabling the site..."
    docker-compose up -d
    echo "The site is up and running. Please open http://$SITE_NAME:8000 in your browser."
}

# Disable the site
function disable_site() {
    echo "Disabling the site..."
    docker-compose down
    sudo sed -i "/$SITE_NAME/d" /etc/hosts
    echo "The site has been disabled."
}

# Delete the site
function delete_site() {
    echo "Deleting the site..."
    docker-compose down
    sudo sed -i "/$SITE_NAME/d" /etc/hosts
    sudo rm -rf ./*
    echo "The site has been deleted."
}

# Check if a subcommand has been provided
if [ $# -gt 1 ]
then
    subcommand=$2
    case $subcommand in
        enable)
            enable_site
            ;;
        disable)
            disable_site
            ;;
        delete)
            delete_site
            ;;
        *)
            echo "Invalid subcommand. Valid subcommands are: enable, disable, delete."
            exit 1
            ;;
    esac
else
    enable_site
fi
