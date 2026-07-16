#!/bin/bash

# Update system
sudo apt update -y
sudo apt upgrade -y

# Install prerequisites
sudo apt install git maven tree curl wget gnupg -y

# Install Java 17 & Java 21 (Jenkins requires Java 17 or 21)
sudo apt install openjdk-17-jdk openjdk-21-jdk -y

# 1. Clean up old/failed repository lists and keys to prevent conflicts
sudo rm -f /usr/share/keyrings/jenkins-keyring.asc
sudo rm -f /etc/apt/sources.list.d/jenkins.list

# 2. Download the official, updated Jenkins GPG key securely
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# 3. Add the Jenkins repository, pointing securely to the new keyring
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# 4. Update apt index to recognize the newly authenticated Jenkins repo
sudo apt update -y

# 5. Install Jenkins
sudo apt install jenkins -y

# Start and enable Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
