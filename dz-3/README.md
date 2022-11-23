
# Задание

## Сделать простейший RESTful CRUD по созданию, удалению, просмотру и обновлению пользователей.

Инструментировать сервис из прошлого задания метриками в формате Prometheus с помощью библиотеки для вашего фреймворка и ЯП.<br>
Сделать дашборд в Графане, в котором были бы метрики с разбивкой по API методам:<br>
<br>
1. Latency (response time) с квантилями по 0.5, 0.95, 0.99, max<br>
2. RPS<br>
3. Error Rate - количество 500ых ответов<br>
Добавить в дашборд графики с метрикам в целом по сервису, взятые с nginx-ingress-controller:<br>
4. Latency (response time) с квантилями по 0.5, 0.95, 0.99, max<br>
5. RPS<br>
6. Error Rate - количество 500ых ответов<br>
Настроить алертинг в графане на Error Rate и Latency.<br>


# На выходе должны быть предоставлены<br>
скриншоты дашборды с графиками в момент стресс-тестирования сервиса. Например, после 5-10 минут нагрузки.<br>
json-дашборды.<br>
Задание со звездочкой (+5 баллов)<br>
Используя существующие системные метрики из кубернетеса, добавить на дашборд графики с метриками:<br>
Потребление подами приложения памяти<br>
Потребление подами приолжения CPU<br>
Инструментировать базу данных с помощью экспортера для prometheus для этой БД.<br>
Добавить в общий дашборд графики с метриками работы БД.<br>

# Решение

Используем сервис из прошлого задания 


```shell

kubectl create ns otus-dz-3

# добавляем репо комунити с готовым стеком 
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install -n otus-dz-3 my-monitoring prometheus-community/kube-prometheus-stack
#   helm install -n otus-dz-3 my-prometheus prometheus-community/prometheus

# прометей
kubectl -n otus-dz-3 expose service my-monitoring-kube-prometh-prometheus --type=NodePort --target-port=9090 --name=prometheus-np
# графана
kubectl -n otus-dz-3 expose service my-monitoring-grafana --type=NodePort --target-port=3000 --name=grafana-np

# Запустим интерфейс графаны 
# default credentials 
# user: admin 
# password: prom-operator
minikube service grafana-np -n otus-dz-3

minikube service app-metrics-np -n otus-dz-3

minikube service prometheus-np -n otus-dz-3

# создаем секрет для подключения к бд
kubectl apply -f .\helm\charts\postgresql\password-secret.yaml

# добавляем репо bitnami
helm repo add bitnami https://charts.bitnami.com/bitnami

# ставим слоника в наш namespace

helm install -n otus-dz-3 my-release bitnami/postgresql --values=.\helm\charts\postgresql\values.yaml 

kubectl create -f .\configmap.yaml

kubectl apply -f .\deployment.yaml -f .\service.yaml -f .\ingress.yaml -f .\service-monitoring.yaml

# приложение с метриками
kubectl -n otus-dz-3 expose service otus-app-service --type=NodePort --target-port=8081 --name=app-metrics-np

# нагрузочное тестирование
ab -k -c 100 -n 10000 http://arch.homework/api/testErrorGenerator

kubectl delete ns otus-dz-3 

```

