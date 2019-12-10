#!/bin/bash

echo Run SONARSCRATCH container from factory...
docker stop sonarqube-sonarscratch
docker rm -v sonarqube-sonarscratch

IMAGE=sonarqube
for ((i = 1; i <= $#; i++)); do
    if [ "${!i}" == "--name" ]; then
        j=$((i + 1))
        IMAGE=${!j}
        break
    fi
done

PORT=9000
for ((i = 1; i <= $#; i++)); do
    if [ "${!i}" == "--port" ]; then
        j=$((i + 1))
        PORT=${!j}
        break
    fi
done

LIMIT=
for ((i = 1; i <= $#; i++)); do
    if [ "${!i}" == "--limit" ]; then
        j=$((i + 1))
        LIMIT="-m ${!j}"
        break
    fi
done

DETACH=-d
for ((i = 1; i <= $#; i++)); do
    if [ "${!i}" == "--debug" ]; then
        DETACH=
        break
    fi
done

docker run --name sonarqube-sonarscratch $DETACH -p $PORT:9000 $LIMIT $IMAGE
