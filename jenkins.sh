
#! /bin/bash
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
# Add required dependencies for the jenkins package
yum install java-17-amazon-corretto jenkins -y
sudo yum install jenkins -y
sudo systemctl restart jenkins
sudo systemctl daemon-reload
