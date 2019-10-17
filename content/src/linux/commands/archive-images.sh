#!/bin/bash

echo Archive all...

mkdir -p $3/$1\
&& $(dirname $0)/archive-image.sh conf $1 $2 $3\
&& $(dirname $0)/archive-image.sh extensions $1 $2 $3\
&& $(dirname $0)/archive-image.sh data $1 $2 $3