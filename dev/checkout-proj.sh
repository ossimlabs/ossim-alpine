#!/bin/bash

if [ ! -d PROJ ] ; then
    git clone https://github.com/OSGeo/PROJ.git
    git checkout tags/6.3.0
    mkdir -p PROJ/build
fi
