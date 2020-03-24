#!/bin/bash

set -e

export GDAL_VERSION="3.0.2"
export GEOS_VERSION="3.8.0"
export GEOTIFF_VERSION="1.5.1"
export KAKADU_VERSION="OrchidIsland-2.11.1"
export PROJ_VERSION="6.3.0"

export DEPS_DIR="${PWD}/deps"

dir="$(dirname $0)"

"${dir}/checkout-gdal.sh"
"${dir}/checkout-geos.sh"
"${dir}/checkout-geotiff.sh"
"${dir}/checkout-kakadu.sh"
"${dir}/checkout-proj.sh"
