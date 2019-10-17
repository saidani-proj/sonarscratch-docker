#!/bin/bash

echo Archive $1...

tar -C $3 -zcf $4/$2/$1.tar.gz $1