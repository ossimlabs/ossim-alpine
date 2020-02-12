#!/bin/bash

if [ ! -d geos ] ; then
./checkout-geos.sh 
fi 

cd geos/build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ..
make -j 8 VERBOSE=1 install
