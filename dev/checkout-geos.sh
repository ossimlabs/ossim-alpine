#!/bin/bash

if [ ! -d geos ] ; then
    git clone https://github.com/libgeos/geos.git
    cd geos
    git checkout tags/3.8.0
    mkdir build
    cd ..
fi 
