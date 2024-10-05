#! /bin/bash
sudo yum update -y
sudo yum install java-1.8* -y
sudo wget https://jfrog.bintray.com/artifactory/jfrog-artifactory-oss-6.9.6.zip
sudo yum install unzip -y
sudo unzip  jfrog-artifactory-oss-6.9.6.zip
cd /opt/jfrog-artifactory-oss-6.9.6/app/bin
sudo ./artifactory.sh start
