
# Задание

Создать минимальный сервис, который

1. отвечает на порту 8000
2. имеет http-метод
`GET /health/`
RESPONSE: `{"status": "OK"}`<br>
Cобрать локально образ приложения в докер.<br>
Запушить образ в dockerhub<br>
Написать манифесты для деплоя в k8s для этого сервиса.<br>
Манифесты должны описывать сущности Deployment, Service, Ingress.<br>
В Deployment могут быть указаны Liveness, Readiness пробы.<br>
Количество реплик должно быть не меньше 2. Image контейнера должен быть указан с Dockerhub.<br>
Хост в ингрессе должен быть arch.homework. В итоге после применения манифестов GET запрос на `http://arch.homework/health` должен отдавать `{“status”: “OK”}`.<br>
На выходе предоставить<br>
3. ссылку на github c манифестами. Манифесты должны лежать в одной директории, так чтобы можно было их все применить одной командой `kubectl apply -f .`<br>
4. url, по которому можно будет получить ответ от сервиса (либо тест в postmanе).<br>
Задание со звездой* (+5 баллов):
В Ingress-е должно быть правило, которое форвардит все запросы с /otusapp/{student name}/* на сервис с rewrite-ом пути. Где {student name} - это имя студента.


# Решение
```shell
kubectl create ns otus-dz-1 && kubectl apply -f .
curl http://arch.homework/health
curl http://arch.homework/otusapp/student_name
```

