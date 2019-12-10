#!/bin/bash

echo Run new SONARSCRATCH container...

IMAGE=sonarqube
IMAGE_INDEX_0=
IMAGE_INDEX_1=
for ((i = 1; i <= $#; i++)); do
    if [ "${!i}" == "--name" ]; then
        j=$((i + 1))
        IMAGE_INDEX_0=$i
        IMAGE_INDEX_1=$j
        IMAGE=${!j}
        break
    fi
done

PORT=9000
PORT_INDEX_0=
PORT_INDEX_1=
for ((i = 1; i <= $#; i++)); do
    if [ "${!i}" == "--port" ]; then
        j=$((i + 1))
        PORT_INDEX_0=$i
        PORT_INDEX_1=$j
        PORT=${!j}
        break
    fi
done

LIMIT=
LIMIT_INDEX_0=
LIMIT_INDEX_1=
for ((i = 1; i <= $#; i++)); do
    if [ "${!i}" == "--limit" ]; then
        j=$((i + 1))
        LIMIT_INDEX_0=$i
        LIMIT_INDEX_1=$j
        LIMIT="-m ${!j}"
        break
    fi
done

ATTACH_INTERACTIVE=
ATTACH_INTERACTIVE_INDEX=
for ((i = 1; i <= $#; i++)); do
    if [ "${!i}" == "--debug" ]; then
        ATTACH_INTERACTIVE_INDEX=$i
        ATTACH_INTERACTIVE=-ai
        break
    fi
done

ROOT=
ROOT_INDEX=
for ((i = 1; i <= $#; i++)); do
    if [ "$i" != "$IMAGE_INDEX_0" ] && [ "$i" != "$IMAGE_INDEX_1" ] &&
        [ "$i" != "$PORT_INDEX_0" ] && [ "$i" != "$PORT_INDEX_1" ] &&
        [ "$i" != "$LIMIT_INDEX_0" ] && [ "$i" != "$LIMIT_INDEX_1" ] &&
        [ "$i" != "$ATTACH_INTERACTIVE_INDEX" ]; then
        ROOT_INDEX=$i
        ROOT="${!i}"
        break
    fi
done

NAME=
for ((i = 1; i <= $#; i++)); do
    if [ "$i" != "$IMAGE_INDEX_0" ] && [ "$i" != "$IMAGE_INDEX_1" ] &&
        [ "$i" != "$PORT_INDEX_0" ] && [ "$i" != "$PORT_INDEX_1" ] &&
        [ "$i" != "$LIMIT_INDEX_0" ] && [ "$i" != "$LIMIT_INDEX_1" ] &&
        [ "$i" != "$ATTACH_INTERACTIVE_INDEX" ] && [ "$i" != "$ROOT_INDEX" ]; then
        NAME="${!i}"
        break
    fi
done

if [ -z "$NAME" ]; then
    NAME=default
fi

if [ -z "$ROOT" ]; then
    echo Root path must be specified
    echo
    echo \'sn-scratch --help\' \for more details
else
    docker stop sonarqube-sonarscratch
    docker rm -v sonarqube-sonarscratch
    docker container create -it --name sonarqube-sonarscratch -p $PORT:9000 $LIMIT --entrypoint bash $IMAGE -c "tar -xf run.tar.gz && ./run.sh" &&
        $(dirname $0)/pull-images.sh $NAME $ROOT &&
        docker start $ATTACH_INTERACTIVE sonarqube-sonarscratch
fi
