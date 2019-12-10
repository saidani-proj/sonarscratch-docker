#!/bin/bash

echo Run...

rm -rf conf/*
tar -xf conf.tar.gz

rm -rf extensions/*
tar -xf extensions.tar.gz

rm -rf data/*
tar -xf data.tar.gz

./bin/run.sh
