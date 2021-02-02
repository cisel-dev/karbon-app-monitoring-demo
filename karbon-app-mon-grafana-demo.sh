#!/bin/bash
# Grafana installation
# Prerequisite helm v3 with stable repo 
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo update

# Create dedicated namespace
kubectl create ns grafana

# Install Grafana helm chart
# Please review the values file before applying
helm install grafana stable/grafana --namespace grafana -f https://raw.githubusercontent.com/cisel-dev/karbon-app-monitoring-demo/main/karbon-app-mon-grafana-values-demo.yaml
kubectl -n grafana rollout status deploy/grafana
export SERVICE_IP=$(kubectl get svc --namespace grafana grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export GF_PASSWORD=$(kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)
echo "you can connect on Grafana http://$SERVICE_IP with admin/$GF_PASSWORD"
