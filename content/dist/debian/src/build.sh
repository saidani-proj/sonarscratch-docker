#!/bin/bash

KEY=
KEEP_TMP=
if [ "$1" == "--key" ]; then
    KEY=$2
    if [ "$3" == "--keep" ]; then
        KEEP_TMP="keep"
    fi
elif [ "$1" == "--keep" ]; then
    KEEP_TMP="keep"
    if [ "$2" == "--key" ]; then
        KEY=$3
    fi
fi

DEBFULLNAME="L.SAIDANI"
export DEBFULLNAME
PACKAGES=$(dirname $(realpath $0))/../packages

TMP=$XDG_RUNTIME_DIR
if [ -z "$TMP" ]; then
    TMP=/tmp
fi
TMP=$TMP/snscratch-build-$RANDOM

echo Building debian SNSCRATCH package \in $TMP
mkdir -p $TMP/build/files/usr/share/sn-scratch &&
    cp -R ../../../src/linux/bin $TMP/build/files/usr/share/sn-scratch &&
    cp -R ../../../src/linux/commands $TMP/build/files/usr/share/sn-scratch &&
    mkdir -p $TMP/build/files/usr/share/sn-scratch/docker &&
    cp ../../../src/docker/run.tar.gz $TMP/build/files/usr/share/sn-scratch/docker &&
    mkdir -p $TMP/build/files/usr/bin &&
    ln -s /usr/share/sn-scratch/bin/sn-scratch.sh $TMP/build/files/usr/bin/sn-scratch &&
    cp install $TMP &&
    cd $TMP/build &&
    dh_make --native --indep --packagename sn-scratch_1.0.0 --email g.tcdorg@gmail.com --copyright mit -y &&
    cp $TMP/install debian &&
    dpkg-buildpackage -k$KEY &&
    cp $TMP/*.deb $PACKAGES

if [ "$KEEP_TMP" != "keep" ]; then
    rm -rf $TMP
fi
