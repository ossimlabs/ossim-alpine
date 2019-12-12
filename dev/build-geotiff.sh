#!/bin/bash

if [ ! -d libgeotiff ] ; then
    git clone https://github.com/OSGeo/libgeotiff.git
    cd libgeotiff
    git checkout tags/1.5.1
    cd ..
fi 

cd libgeotiff/libgeotiff
./autogen.sh
./configure --prefix=/usr/local --enable-shared --disable-static
make -j 8 install
