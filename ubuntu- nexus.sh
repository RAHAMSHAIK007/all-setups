#!/bin/bash
# Nexus Installation Script for Ubuntu Server 26.04 LTS
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
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y wget tar openjdk-17-jdk curl

# Step 2: Create nexus group and user explicitly
echo -e "${GREEN}[2/8] Creating nexus system user and group...${NC}"
if ! getent group nexus >/dev/null; then
    sudo groupadd nexus
fi
if ! id -u nexus &>/dev/null; then
    sudo useradd -m -g nexus -s /bin/bash nexus
fi

# Step 3: Download Nexus
echo -e "${GREEN}[3/8] Downloading Nexus...${NC}"
cd /opt
sudo wget https://download.sonatype.com/nexus/3/nexus-unix-x86-64-${NEXUS_VERSION}.tar.gz

# Step 4: Extract Nexus
echo -e "${GREEN}[4/8] Extracting Nexus...${NC}"
sudo tar -zxvf nexus-unix-x86-64-${NEXUS_VERSION}.tar.gz

# Step 5: Rename for simplicity and clean up archive
echo -e "${GREEN}[5/8] Setting up directories...${NC}"
sudo mv nexus-${NEXUS_VERSION} nexus
sudo rm -f nexus-unix-x86-64-${NEXUS_VERSION}.tar.gz

# Step 6: Configure Ubuntu Security Limits (Critical for Nexus performance on SSD)
echo -e "${GREEN}[6/8] Configuring system file descriptor limits...${NC}"
if ! grep -q "nexus entries" /etc/security/limits.conf; then
sudo cat >> /etc/security/limits.conf << 'EOF'
# nexus entries
nexus soft nofile 65536
nexus hard nofile 65536
EOF
fi

# Step 7: Configure Nexus parameters and set permissions
echo -e "${GREEN}[7/8] Configuring Nexus execution context...${NC}"
sudo cat > /opt/nexus/bin/nexus.rc << 'EOF'
run_as_user="nexus"
EOF

# Ensure all target production directories belong to the nexus runner
sudo chown -R nexus:nexus /opt/nexus /opt/sonatype-work

# Step 8: Create systemd service
echo -e "${GREEN}[8/8] Creating systemd service...${NC}"
sudo cat > /etc/systemd/system/nexus.service << 'EOF'
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

# Reload systemd and launch the application engine
echo -e "${GREEN}=== Launching Nexus Service ===${NC}"
sudo systemctl daemon-reload
sudo systemctl enable nexus
sudo systemctl start nexus

# Wait for Nexus JVM engine to initialize 
echo -e "${GREEN}Waiting for Nexus to boot up (30 seconds)...${NC}"
sleep 30

# Check operational status
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo -e "${GREEN}Nexus Status:${NC}"
sudo systemctl status nexus --no-pager

# Retrieve instance public IP address
SERVER_IP=$(curl -s ifconfig.me)

echo -e "\n${GREEN}=== Access Information ===${NC}"
echo -e "Nexus URL: http://${SERVER_IP}:8081"
echo -e "Default Admin Password location: /opt/sonatype-work/nexus3/admin.password"
echo -e "\nTo view the temporary admin password run:"
echo -e "${RED}sudo cat /opt/sonatype-work/nexus3/admin.password${NC}"
