#!/bin/bash

if [ ! -d gdal ] ; then
   git clone https://github.com/OSGeo/gdal.git   
   cd gdal
   git checkout tags/v3.0.2
   cd ..
fi