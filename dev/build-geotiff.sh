#!/bin/bash

if [ ! -d libgeotiff ] ; then
./checkout-geotiff.sh
fi 

cd libgeotiff/libgeotiff
./autogen.sh
./configure --prefix=/usr/local --enable-shared --disable-static
make -j 8 install
