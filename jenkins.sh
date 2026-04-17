#!/bin/bash

# Update system
sudo dnf update -y

# Install Java 21
sudo dnf install -y java-21-amazon-corretto

# Verify Java
java -version

# Install wget (if not installed)
sudo dnf install -y wget

# Add Jenkins repo
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import Jenkins key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
sudo dnf install -y jenkins

# Enable Jenkins service
sudo systemctl enable jenkins

# Start Jenkins
sudo systemctl start jenkins

# Check status
sudo systemctl status jenkins
