#! /bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git apt-transport-https ca-certificates gnupg lsb-release
sudo swapoff -a
sudo sed -i '/swap/d' /etc/fstab
curl -sfL https://get.k3s.io | sh -
sudo kubectl get nodes
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
kubectl get pods -A

sleep 10
kubectl create namespace argocd
kubectl apply --server-side --force-conflicts -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable
kubectl get pods -n argocd
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
kubectl get svc argocd-server -n argocd
