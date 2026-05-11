#!/bin/bash
# Nexus Installation Script for Amazon Linux 2023
# Run with: sudo bash nexus-install.sh
set -e  # Exit on error
# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color
echo -e "${GREEN}=== Starting Nexus Installation ===${NC}"
# Variables
NEXUS_VERSION="3.79.0-09"
NEXUS_HOME="/opt/nexus"
SONATYPE_WORK="/opt/sonatype-work"
# Step 1: Update system and install dependencies
echo -e "${GREEN}[1/8] Updating system and installing dependencies...${NC}"
dnf update -y
dnf install -y wget tar java-17-amazon-corretto
# Step 2: Create nexus user if not exists
echo -e "${GREEN}[2/8] Creating nexus user...${NC}"
id -u nexus &>/dev/null || useradd -m -s /bin/bash nexus
# Step 3: Download Nexus
echo -e "${GREEN}[3/8] Downloading Nexus...${NC}"
cd /opt
wget https://download.sonatype.com/nexus/3/nexus-unix-x86-64-${NEXUS_VERSION}.tar.gz
# Step 4: Extract Nexus
echo -e "${GREEN}[4/8] Extracting Nexus...${NC}"
tar -zxvf nexus-unix-x86-64-${NEXUS_VERSION}.tar.gz
# Step 5: Rename for simplicity
echo -e "${GREEN}[5/8] Setting up directories...${NC}"
mv nexus-${NEXUS_VERSION} nexus
# Step 6: Set permissions
echo -e "${GREEN}[6/8] Setting permissions...${NC}"
chown -R nexus:nexus /opt/nexus /opt/sonatype-work
# Step 7: Configure Nexus to run as nexus user
echo -e "${GREEN}[7/8] Configuring Nexus...${NC}"
cat > /opt/nexus/bin/nexus.rc << EOF
run_as_user="nexus"
EOF
# Step 8: Create systemd service
echo -e "${GREEN}[8/8] Creating systemd service...${NC}"
cat > /etc/systemd/system/nexus.service << EOF
[Unit]
Description=Nexus Repository Manager
After=network.target
[Service]
Type=forking
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
Restart=on-abort
LimitNOFILE=65536
[Install]
WantedBy=multi-user.target
EOF
# Reload systemd and start Nexus
systemctl daemon-reload
systemctl enable nexus
systemctl start nexus
# Wait for Nexus to start
echo -e "${GREEN}Waiting for Nexus to start (30 seconds)...${NC}"
sleep 30
# Check status
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo -e "${GREEN}Nexus Status:${NC}"
systemctl status nexus --no-pager
# Get server IP
SERVER_IP=$(curl -s ifconfig.me)
echo -e "\n${GREEN}=== Access Information ===${NC}"
echo -e "Nexus URL: http://${SERVER_IP}:8081"
echo -e "Default Admin Password: cat /opt/sonatype-work/nexus3/admin.password"
echo -e "\nTo view admin password:"
echo -e "${RED}sudo cat /opt/sonatype-work/nexus3/admin.password${NC}"
