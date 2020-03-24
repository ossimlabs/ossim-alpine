#!/bin/bash 

set -e

echo "@@@ Building PROJ"
/build_scripts/build-proj.sh

echo "@@@ Building geos"
/build_scripts/build-geos.sh

echo "@@@ Building gdal"
/build_scripts/build-gdal.sh

echo "@@@ Building geotiff"
/build_scripts/build-geotiff.sh

echo "@@@ Building kakadu"
/build_scripts/build-kakadu.sh

for x in `find /usr/local/bin /usr/local/lib /usr/local/lib64 -type f`; do
  strip $x || true
done