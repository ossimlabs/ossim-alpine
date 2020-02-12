#!/bin/bash

if [ ! -d gdal ] ; then
./checkout-gdal.sh
fi

cd gdal/gdal
./configure --with-proj=/usr/local --with-jpeg=internal --prefix=/usr/local --enable-shared --disable-static 
make -j 8 install
