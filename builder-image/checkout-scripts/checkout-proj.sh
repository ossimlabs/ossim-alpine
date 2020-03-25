#!/bin/bash

set -e
dir="${DEPS_DIR}/PROJ"

if [ ! -d "${dir}" ] ; then
    git clone https://github.com/OSGeo/PROJ.git "${dir}"
    cd "${dir}"
    git checkout "tags/${PROJ_VERSION}"
    mkdir -p build
fi
