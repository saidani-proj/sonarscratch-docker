#!/bin/bash

echo Run SONARSCRATCH container from factory...
docker stop sonarqube-sonarscratch
docker rm -v sonarqube-sonarscratch

DEBUG=
if [ "$1" != "-d" ]; then
    DEBUG=-d
fi

docker run --name sonarqube-sonarscratch $DEBUG -p 9000:9000 sonarqube