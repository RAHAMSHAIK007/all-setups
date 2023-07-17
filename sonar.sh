#! /bin/bash
#Launch an instance with 9000 and t2.medium
cd /opt/
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.6.50800.zip
unzip sonarqube-8.9.6.50800.zip
amazon-linux-extras install java-openjdk11 -y
useradd sonar
chown sonar:sonar filename  -R
chmod 777 filename -R
su - sonar
cd /opt
cd sonarqube-8.9.6.50800/bin/linux/
./sonar.sh start
./sonar status
