#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc


#! /bin/bash
aws configure
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.25.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops

aws s3api create-bucket --bucket cloudanddevopsbyraham0073456.k8s.local --region us-east-1
aws s3api put-bucket-versioning --bucket cloudanddevopsbyraham0073456.k8s.local --region us-east-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://cloudanddevopsbyraham0073456.k8s.local
kops create cluster --name rahams.k8s.local --zones us-east-1a --master-count=1 --master-size t2.medium --node-count=2 --node-size t2.medium
kops update cluster --name rahams.k8s.local --yes --admin
