#!/bin/sh
docker build -t gubanovss/otus-app:dz-4.1 --build-arg VER=1 .
docker build -t gubanovss/otus-app:dz-4.2 --build-arg VER=2 .
docker push gubanovss/otus-app:dz-4.1
docker push gubanovss/otus-app:dz-4.2
