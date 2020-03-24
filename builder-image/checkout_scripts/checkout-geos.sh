#!/bin/bash

set -e
dir="${DEPS_DIR}/geos"

if [ ! -d "${dir}" ] ; then
    git clone https://github.com/libgeos/geos.git "${dir}"
    cd "${dir}"
    git checkout "tags/${GEOS_VERSION}"
    mkdir build
fi 
