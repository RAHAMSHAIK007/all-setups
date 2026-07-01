#!/bin/bash

# AWS EKS Setup Script (UPDATED - Kubernetes 1.36)
set -e

echo "Updating system..."
sudo dnf update -y --allowerasing --best --skip-broken

echo "Installing dependencies..."
sudo dnf install -y unzip curl tar git --allowerasing --best --skip-broken

# Install AWS CLI v2
if ! command -v aws &> /dev/null
then
  echo "Installing AWS CLI..."
  curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -oq awscliv2.zip
  sudo ./aws/install
fi

echo ">>> Run 'aws configure' manually if not configured"

# Install kubectl (v1.36.0)
echo "Installing kubectl v1.36.0..."
curl -LO "https://dl.k8s.io/release/v1.36.0/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv -f kubectl /usr/local/bin/

kubectl version --client

# Install eksctl
echo "Installing eksctl..."
curl --silent --location \
"https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" \
| tar xz -C /tmp

sudo mv -f /tmp/eksctl /usr/local/bin

eksctl version

# Create EKS Cluster (Kubernetes version 1.36)
eksctl create cluster \
  --name=kscluster \
  --region=us-east-1 \
  --zones=us-east-1a,us-east-1b \
  --version=1.36 \
  --without-nodegroup

# Associate IAM OIDC Provider
eksctl utils associate-iam-oidc-provider \
  --cluster kscluster \
  --region us-east-1 \
  --approve

# Install Amazon EKS Pod Identity Agent Add-on
eksctl create addon \
  --name eks-pod-identity-agent \
  --cluster kscluster \
  --region us-east-1

# Create Nodegroup (Kubernetes version 1.36)
eksctl create nodegroup \
  --cluster=kscluster \
  --region=us-east-1 \
  --name=aws-eks-cluster \
  --node-type=t3.medium \
  --nodes=3 \
  --node-volume-size=20 \
  --ssh-access \
  --ssh-public-key=All \
  --managed \
  --asg-access \
  --external-dns-access \
  --full-ecr-access \
  --alb-ingress-access \
  --appmesh-access

# Install Metrics Server for EKS
eksctl create addon \
  --name metrics-server \
  --cluster kscluster \
  --region us-east-1

echo "EKS Setup Completed!"

#----------------------------------------
# Deleting commands for eks
#----------------------------------------
#eksctl delete nodegroup --cluster=kscluster --name=aws-eks-cluster --region=us-east-1
#eksctl delete cluster --name=kscluster --region=us-east-1
#rm -rf ~/.kube
#sudo rm -f /usr/local/bin/eksctl
#sudo rm -f /usr/local/bin/kubectl
#sudo rm -rf /usr/local/aws-cli
#sudo rm -f /usr/local/bin/aws
#sudo rm -f /usr/local/bin/aws_completer
