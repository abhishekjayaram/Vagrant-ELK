#!/bin/bash

# Update the virtual machine
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install wget -y

# Install VirtualBox Guest Additions
sudo apt-get install linux-headers-$(uname -r) build-essential dkms
mkdir -p /media/cdrom
sudo mount /dev/cdrom /media/cdrom
sudo sh /media/cdrom/VBoxLinuxAdditions.run

# install Java 8
sudo apt-get install openjdk-8-jdk-headless -y
java -version

SITE="https://artifacts.elastic.co/downloads"

# Download install Elasticsearch
ELS="elasticsearch"
wget $SITE/$ELS/$ELS-7.8.0-amd64.deb
wget $SITE/$ELS/$ELS-7.8.0-amd64.deb.sha512
shasum -a 512 -c $ELS-7.8.0-amd64.deb.sha512 
sudo dpkg -i $ELS-7.8.0-amd64.deb

# Change Elasticsearch Configs
sudo cp /etc/$ELS/$ELS.yml /etc/$ELS/$ELS.yml.backup
sudo echo "network.host: localhost" | tee -a /etc/$ELS/$ELS.yml
sudo echo "http.port: 9200" | tee -a /etc/$ELS/$ELS.yml
sudo systemctl restart $ELS
sudo systemctl enable $ELS

# Download and Install Kibana
KBN="kibana"
wget $SITE/$KBN/$KBN-7.8.0-amd64.deb
shasum -a 512 $KBN-7.8.0-amd64.deb 
sudo dpkg -i $KBN-7.8.0-amd64.deb

# Change Kibana Configs
sudo cp /etc/$KBN/$KBN.yml /etc/$KBN/$KBN.yml.backup
sudo echo "server.name: \"localhost\"" | tee -a /etc/$KBN/$KBN.yml
sudo echo "elasticsearch.hosts: [\"http://localhost:9200\"]" | tee -a /etc/$KBN/$KBN.yml
sudo systemctl restart $KBN
sudo systemctl enable $KBN

# Download and Install Logstash
LGS="logstash"
wget $SITE/$LGS/$LGS-7.8.0.deb
sudo dpkg -i $LGS-7.8.0.deb

# Install nginx reverse proxy
sudo apt-get install nginx -y
sudo cp /vagrant/default /etc/nginx/sites-enabled/default
sudo systemctl restart nginx