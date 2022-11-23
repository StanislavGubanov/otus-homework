kubectl delete ns otus-dz-3
kubectl create ns otus-dz-3
helm install -n otus-dz-3 my-monitoring prometheus-community/kube-prometheus-stack
kubectl -n otus-dz-3 expose service my-monitoring-grafana --type=NodePort --target-port=3000 --name=grafana-np
kubectl -n otus-dz-3 expose service my-monitoring-kube-prometh-prometheus --type=NodePort --target-port=9090 --name=prometheus-np
kubectl apply -f .\helm\charts\postgresql\password-secret.yaml
helm install -n otus-dz-3 my-release bitnami/postgresql --values=.\helm\charts\postgresql\values.yaml
kubectl create -f .\configmap.yaml
kubectl apply -f .\deployment.yaml -f .\service.yaml -f .\ingress.yaml -f .\service-monitoring.yaml
kubectl -n otus-dz-3 expose service otus-app-service --type=NodePort --target-port=8081 --name=app-metrics-np

echo "open prom: minikube service prometheus-np -n otus-dz-3"
echo "open grafana: minikube service grafana-np -n otus-dz-3"
echo "open metrics app: minikube service app-metrics-np -n otus-dz-3"

echo "./ab -k -c 100 -n 100000 http://arch.homework/api/testErrorGenerator"

echo "goto grafana ui and add dashboards from grafana directory"

