#!/bin/bash
# Launch an instance with port 9000 open and t2.medium or t3.medium
# OS: Amazon Linux 2023 (Kernel 6.1 or 6.1.x)

# 1. Install prerequisites
dnf update -y
dnf install wget unzip -y

# 2. Install Java 17 (Required for SonarQube 9.9+)
dnf install java-17-amazon-corretto -y

# 3. Increase OS limits for Elasticsearch (Required, or SonarQube will crash)
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
echo "fs.file-max=131072" >> /etc/sysctl.conf
sysctl -p

# 4. Download and extract SonarQube
cd /opt/
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.6.92038.zip
unzip sonarqube-9.9.6.92038.zip
mv sonarqube-9.9.6.92038 sonarqube

# 5. Create user and fix permissions
useradd sonar
chown -R sonar:sonar /opt/sonarqube

# 6. Start SonarQube as the sonar user (non-interactive)
su - sonar -c "/opt/sonarqube/bin/linux-x86-64/sonar.sh start"

echo "SonarQube is starting. Note: It may take 2-3 minutes for the web UI to become available."
echo "Default credentials -> user=admin & password=admin"
