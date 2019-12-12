#!/bin/bash

if [ ! -d gdal ] ; then
   git clone https://github.com/OSGeo/gdal.git   
   cd gdal
   git checkout tags/v3.0.2
   cd ..
fi

cd gdal/gdal
./configure --with-proj=/usr/local --with-jpeg=internal --prefix=/usr/local --enable-shared --disable-static 
make -j 8 install
