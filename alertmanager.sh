#!/bin/bash

set -e

# Variables
VERSION="0.18.0"
USER="alertmanager"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/alertmanager"
DATA_DIR="/data/alertmanager"

# Download Alertmanager
cd /tmp
wget https://github.com/prometheus/alertmanager/releases/download/v${VERSION}/alertmanager-${VERSION}.linux-amd64.tar.gz

# Extract
tar -xvzf alertmanager-${VERSION}.linux-amd64.tar.gz

# Move binaries
sudo mv alertmanager-${VERSION}.linux-amd64/alertmanager ${INSTALL_DIR}/
sudo mv alertmanager-${VERSION}.linux-amd64/amtool ${INSTALL_DIR}/

# Create user (if not exists)
sudo useradd alertmanager
id -u ${USER} &>/dev/null || sudo useradd -rs /bin/false ${USER}

# Create directories
sudo mkdir -p ${CONFIG_DIR}
sudo mkdir -p ${DATA_DIR}

# Create basic config (edit later for email/slack)
sudo tee ${CONFIG_DIR}/alertmanager.yml > /dev/null <<EOF
global:
  resolve_timeout: 5m

route:
  receiver: "default"

receivers:
  - name: "default"
EOF

# Set permissions
sudo chown -R ${USER}:${USER} ${CONFIG_DIR}
sudo chown -R ${USER}:${USER} ${DATA_DIR}
sudo chown ${USER}:${USER} ${INSTALL_DIR}/alertmanager ${INSTALL_DIR}/amtool

# Remove old/masked service if exists
sudo systemctl stop alertmanager 2>/dev/null || true
sudo systemctl disable alertmanager 2>/dev/null || true
sudo systemctl unmask alertmanager 2>/dev/null || true
sudo rm -f /etc/systemd/system/alertmanager.service
sudo rm -f /lib/systemd/system/alertmanager.service

# Create systemd service (CORRECT LOCATION)
sudo tee /etc/systemd/system/alertmanager.service > /dev/null <<EOF
[Unit]
Description=Prometheus Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=${USER}
Group=${USER}
Type=simple
ExecStart=${INSTALL_DIR}/alertmanager \\
  --config.file=${CONFIG_DIR}/alertmanager.yml \\
  --storage.path=${DATA_DIR}

Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
sudo systemctl daemon-reexec
sudo systemctl daemon-reload

# Enable & start service
sudo systemctl enable alertmanager
sudo systemctl start alertmanager

# Status check
sudo systemctl status alertmanager --no-pager

echo "Access Alertmanager UI: http://<your-server-ip>:9093"
