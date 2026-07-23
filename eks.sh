SETUP: TAKE UBUNTU AMI M7I-FLEX.LARGE AND 30 GB EBS FOR THIS CONCEPT

#STEP-1: UPDATE

sudo -i
apt update && apt install unzip -y

#STEP-2: AWS CLI INSTALLATION & EKS & KUBECTL 

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure

curl -LO https://dl.k8s.io/release/v1.35.0/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/kubectl


sudo wget https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz
sudo tar -xzvf eksctl_$(uname -s)_amd64.tar.gz -C /usr/local/bin
eksctl version


#STEP-3: CREATE CLUSTER
eksctl create cluster --name=raham-cluster --version 1.32 --zones=ap-south-1a,ap-south-1b,ap-south-1c --without-nodegroup


kubectl cluster-info
kubectl cluster-info dump

eksctl utils associate-iam-oidc-provider --region ap-south-1 --cluster raham-cluster --approve

#STEP-4: CREATE NODEGROUP
eksctl create nodegroup --cluster=raham-cluster --region=ap-south-1 \
--name=raham-cluster-ng-1 --node-type=t2.medium \
--nodes=2 --nodes-min=2 --nodes-max=4 --node-volume-size=20 \
--ssh-access  --ssh-public-key=Mac \
--managed --asg-access --external-dns-access --full-ecr-access \
--appmesh-access --alb-ingress-access


eksctl get clusters
eksctl get nodegroup --cluster raham-cluster 

#STEP-5: DELETE RESOURCES  
eksctl delete nodegroup --cluster raham-cluster --name raham-cluster-ng-1
eksctl delete cluster --name=raham-cluster
