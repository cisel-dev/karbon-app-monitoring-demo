#!/bin/bash

# Set label on the system namespace
kubectl label ns/kube-system monitoring=k8s
kubectl label ns/ntnx-system monitoring=k8s

# Patch existing prometheus resource to limit ServiceMonitors used
kubectl -n ntnx-system patch --type merge prometheus/k8s -p '{"spec":{"serviceMonitorNamespaceSelector":{"matchLabels":{"monitoring": "k8s"}}}}'
kubectl apply -f https://raw.githubusercontent.com/cisel-dev/karbon-app-monitoring-demo/main/karbon-app-mon-rbac-demo.yml
kubectl apply -f https://raw.githubusercontent.com/cisel-dev/karbon-app-monitoring-demo/main/karbon-app-mon-prometheus-demo.yml
kubectl apply -f https://raw.githubusercontent.com/cisel-dev/karbon-app-monitoring-demo/main/karbon-app-mon-service-monitor-demo.yml
