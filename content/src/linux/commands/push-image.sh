#!/bin/bash

echo Push image $1...

docker cp sonarqube-sonarscratch:/opt/sonarqube/$1 $2