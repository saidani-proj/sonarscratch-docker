#!/bin/bash

echo Start SONARSCRATCH container...

ATTACH_INTERACTIVE=
if [ "$1" == "--debug" ]; then
    ATTACH_INTERACTIVE=-ai
fi

docker start $ATTACH_INTERACTIVE sonarqube-sonarscratch
