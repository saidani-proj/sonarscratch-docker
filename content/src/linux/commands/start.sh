#!/bin/bash

echo Start SONARSCRATCH container...

DEBUG=
if [ "$1" == "-d" ]; then
    DEBUG=-ai
fi

docker start $DEBUG sonarqube-sonarscratch