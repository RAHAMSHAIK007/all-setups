#!/bin/bash

echo "=== Updating System Package Lists ==="
sudo apt update -y && sudo apt upgrade -y

echo "=== Installing Essential Tools & System Dependencies ==="
sudo apt install git maven tree fontconfig ca-certificates curl gnupg2 -y

echo "=== Installing Java Runtimes ==="
sudo apt install openjdk-17-jdk openjdk-21-jdk -y
sudo update-alternatives --config java

echo "=== Registering the Updated 2026 Jenkins GPG Key ==="
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key | sudo tee /etc/apt/keyrings/jenkins-keyring.asc > /dev/null

echo "=== Appending the Jenkins Stable Repository ==="
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "=== Running Jenkins Deployment ==="
sudo apt install jenkins -y

echo "=== Starting and Activating Service ==="
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
