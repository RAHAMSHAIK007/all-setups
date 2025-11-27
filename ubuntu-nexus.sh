#! /bin/bash
wget https://download.sonatype.com/nexus/3/nexus-unix-x86-64-3.79.0-09.tar.gz
tar -zxvf nexus-unix-x86-64-3.79.0-09.tar.gz
yum install java-17-amazon-corretto -y
sudo useradd nexus
chown -R  nexus:nexus  nexus-3.79.0-09
sudo sh nexus-3.79.0-09/bin/nexus start
