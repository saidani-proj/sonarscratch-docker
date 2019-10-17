#!/bin/bash

echo Pull images...

$(dirname $0)/pull-image.sh conf $1 $2 \
&& $(dirname $0)/pull-image.sh extensions $1 $2 \
&& $(dirname $0)/pull-image.sh data $1 $2 \
&& docker cp $(dirname $0)/../docker/run.tar.gz sonarqube-sonarscratch:/opt/sonarqube