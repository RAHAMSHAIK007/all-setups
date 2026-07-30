#PROMETHEUS GRAFANA

INSTALLATION OF HELM:
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version


INSTALLATION OF METRIC SERVER:
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/high-availability-1.21+.yaml

CHARTS WEBSITE LINK: https://artifacthub.io/

DOWNLOADING CHARTS PROMETHEUS & GRAFANA:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts


UPDATE HELM CHART REPOS:
helm repo update
helm repo list

CREATE PROMETHEUS NAMESPACE:
kubectl create namespace prometheus
kubectl create namespace grafana
kubectl get ns

INSTALL PROMETHEUS:

helm install prometheus prometheus-community/prometheus --namespace prometheus --set alertmanager.persistentVolume.storageClass="gp2" --set server.persistentVolume.storageClass="gp2"
kubectl get all -n prometheus

INSTALL GRAFANA:

helm install grafana grafana/grafana --namespace grafana  --set adminPassword='RahamDevOps' --set  service.type=NodePort
kubectl get all -n grafana
kubectl get svc -n grafana

NOTE: ALLOW PORTS ON SG

Copy the EXTERNAL-IP and paste in browser

Go to Grafana Dashboard → Add the Datasource → Select the Prometheus
add the below url in Connection and save and test
http://prometheus-server.prometheus.svc.cluster.local/

Import Grafana dashboard from Grafana Labs
grafana dashboard → new → Import → 14623 → load → select prometheus → import


#ARGOCD INSTALLATION


STEP-1: INSTALL ARGO CD USING HELM
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo update
kubectl create namespace argocd
helm install argocd argo-cd/argo-cd -n argocd 
kubectl get all -n argocd


EXPOSE ARGOCD SERVER:
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get all -n argocd
NOTE: GIVE OR CHECK SG FOR PORTS

COPY PASTE DNS TO BROWSER -- > ADVANCE  -- > LOGIN PAGE

username: admin
passowd: 

TO GET ARGO CD PASSWORD:

kubectl -n argocd get secret argocd-initial-admin-secret -o yaml 
decode the above secret (echo -n "data" | base64 -d)


The above command to provide password to access argo cd

# DEPLOYMENT
NEW APP
NAME: APP1
PROJECT NAME: default
Sync Policy: Manual
REPO: https://github.com/devopsbyraham/argocd.git
PATH: ./
CLUSTER URL: https://kubernetes.default.svc
NAMESPACE: default
CREATE
