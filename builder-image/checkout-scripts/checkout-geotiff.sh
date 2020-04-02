#!/bin/bash

set -e
dir="${DEPS_DIR}/libgeotiff"

if [ ! -d "${dir}" ] ; then
    git clone https://github.com/OSGeo/libgeotiff.git "${dir}"
    cd "${dir}"
    git checkout "tags/${GEOTIFF_VERSION}"
fi 