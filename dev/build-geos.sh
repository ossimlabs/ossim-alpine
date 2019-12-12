#!/bin/bash

if [ ! -d geos ] ; then
    git clone https://github.com/libgeos/geos.git
    cd geos
    git checkout tags/3.8.0
    mkdir build
    cd ..
fi 

cd geos/build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ..
make -j 8 VERBOSE=1 install
