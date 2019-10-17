#!/bin/bash

echo Pull image $1...

docker cp $3/$2/$1.tar.gz sonarqube-sonarscratch:/opt/sonarqube