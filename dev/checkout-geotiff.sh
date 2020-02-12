#!/bin/bash

if [ ! -d libgeotiff ] ; then
    git clone https://github.com/OSGeo/libgeotiff.git
    cd libgeotiff
    git checkout tags/1.5.1
    cd ..
fi 