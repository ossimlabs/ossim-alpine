#!/bin/bash

if [ ! -d PROJ ] ; then
./build-proj.sh
fi

cd PROJ/build
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local .. 
make -j 8 VERBOSE=true install
