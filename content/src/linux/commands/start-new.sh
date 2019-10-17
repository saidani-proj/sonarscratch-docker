#!/bin/bash

echo Run new SONARSCRATCH container...

ROOT=$1
NAME=$2
DEBUG=

if [ "$1" == "-d" ] || [ "$2" == "-d" ] || [ "$3" == "-d" ]; then
    DEBUG=-ai

    if [ "$1" == "-d" ]; then
        ROOT=$2
        NAME=$3
    elif [ "$2" == "-d" ]; then
        ROOT=$1
        NAME=$3
    fi
fi

if [ -z "$NAME" ] ; then
    NAME=default
fi

if [ -z "$ROOT" ] ; then
    echo Root path must be specified
    echo
    echo \'sn-scratch --help\' \for more details
else
    docker stop sonarqube-sonarscratch
    docker rm -v sonarqube-sonarscratch
    docker container create -it --name sonarqube-sonarscratch -p 9000:9000 --entrypoint bash sonarqube -c "tar -xf run.tar.gz && ./run.sh" \
    && $(dirname $0)/pull-images.sh $NAME $ROOT \
    && docker start $DEBUG sonarqube-sonarscratch
fi