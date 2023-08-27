#vim .bashrc
#export PATH=$PATH:/usr/local/bin
#source .bashrc

yum install docker -y
systemctl start docker
systemctl status docker
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo mv kubectl /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo yum install iptables -y
yum install conntrack -y
minikube start --driver=docker --force
minikube status 
