yum install docker -y
systemctl enable docker
systemctl start docker
systemctl status docker
docker --version
yum install conntrack -y
yum install git -y
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
/usr/local/bin/minikube start --force --driver=docker
/usr/local/bin/minikube version
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl/usr/local/bin/kubectl
/usr/local/bin/kubectl vers
