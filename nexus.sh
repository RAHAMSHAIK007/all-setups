#create amazonlinux ec2 with t2.micro and 30 gb of ebs with port 8081 

sudo yum update -y
sudo yum install wget -y
sudo yum install java-1.8.0-openjdk.x86_64 -y
sudo mkdir /app && cd /app
sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo tar -xvf nexus.tar.gz
sudo mv nexus-3* nexus
sudo adduser nexus
sudo chown -R nexus:nexus /app/nexus
sudo chown -R nexus:nexus /app/sonatype-work
sudo echo "run_as_user="nexus"" > /app/nexus/bin/nexus.rc
sudo tee /etc/systemd/system/nexus.service > /dev/null << EOL
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/app/nexus/bin/nexus start
ExecStop=/app/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOL
sudo chkconfig nexus on
sudo systemctl start nexus
sudo systemctl status nexus

