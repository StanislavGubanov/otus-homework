
# Задание

Развернуть в кластере две версии приложения и настроить балансировку трафика между ними

## Цель:

Разворачивать Istio в кластере Kubernetes;
Настраивать балансировку трафика между разными версиями приложения.

# Решение
```shell

minikube start

minikube start --memory 8192 --cpus 4

istioctl install --set profile=demo -y

# check Istio
kubectl get all -n istio-system

# create service
kubectl apply -f ./k8s/service.yaml

# create deployment for app-v1 and app-v2 
kubectl apply -f ./k8s/deployment.yaml

# create canary deployment
kubectl apply -f ./k8s/canary-deployment.yaml

```

