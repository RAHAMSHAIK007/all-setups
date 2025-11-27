#! /bin/bash
aws configure
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.33.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops
echo "export PATH=$PATH:/usr/local/bin/" >> source .bashrc

export KOPS_STATE_STORE=s3://cloudanddevopsbyraham0073456.k8s.local
kops create cluster --name rahamss.k8s.local --zones ap-south-1a --control-plane-image ami-02b8269d5e85954ef  --control-plane-count=1 --control-plane-size c7i-flex.large --image ami-02b8269d5e85954ef  --node-count=2 --node-size c7i-flex.large
kops update cluster --name rahamss.k8s.local --yes --admin
