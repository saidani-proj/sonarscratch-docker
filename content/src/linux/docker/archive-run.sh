#!/bin/bash

echo Archive run...

tar -C $(dirname $0)/../../docker -zcf $(dirname $0)/../../docker/run.tar.gz run.sh