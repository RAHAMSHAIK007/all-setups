#!/bin/bash

# SonarQube Version
SONARQUBE_VERSION="9.9.8.100196"

# Update system packages
echo "Updating system packages..."
sudo yum update -y

# Install required utilities
echo "Installing utilities..."
sudo yum install -y wget unzip tar

# Install Java 17
echo "Installing Java 17..."
sudo amazon-linux-extras enable corretto17
sudo yum install -y java-17-amazon-corretto

# Verify Java installation
java -version

# Download SonarQube
echo "Downloading SonarQube version 9.9.8.100196..."
cd /opt/
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.8.100196.zip

# Extract SonarQube
echo "Extracting SonarQube..."
sudo unzip sonarqube-9.9.8.100196.zip

# Set permissions for SonarQube
echo "Setting permissions for SonarQube..."
sudo useradd sonar || echo "User 'sonar' already exists"
sudo chown -R sonar:sonar /opt/sonarqube-9.9.8.100196
sudo chmod -R 755 /opt/sonarqube-9.9.8.100196

# Create a systemd service file
echo "Creating SonarQube service file..."
sudo bash -c 'cat > /etc/systemd/system/sonarqube.service << EOF
[Unit]
Description=SonarQube service
After=network.target

[Service]
Type=forking
ExecStart=/bin/bash /opt/sonarqube-9.9.8.100196/bin/linux-x86-64/sonar.sh start
ExecStop=/bin/bash /opt/sonarqube-9.9.8.100196/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always
LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target
EOF'

# Reload systemd and start SonarQube
echo "Starting SonarQube..."
sudo systemctl daemon-reload
sudo systemctl enable sonarqube.service
sudo systemctl start sonarqube.service

# Check SonarQube status
echo "Checking SonarQube service status..."
sudo systemctl status sonarqube.service

# Display completion message
echo "SonarQube setup is complete. Access it at http://<INSTANCE_PUBLIC_IP>:9000"
echo "Default credentials are username: admin, password: admin"
