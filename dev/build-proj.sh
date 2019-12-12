#!/bin/bash

if [ ! -d PROJ ] ; then
    git clone https://github.com/OSGeo/PROJ.git
    git checkout tags/6.2.0
    mkdir -p PROJ/build
fi

cd PROJ/build
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local .. 
make -j 8 VERBOSE=true install
