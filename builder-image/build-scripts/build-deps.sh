#!/bin/bash 

set -e

echo "@@@ Building PROJ"
/build-scripts/build-proj.sh

echo "@@@ Building geos"
/build-scripts/build-geos.sh

echo "@@@ Building gdal"
/build-scripts/build-gdal.sh

echo "@@@ Building geotiff"
/build-scripts/build-geotiff.sh

echo "@@@ Building kakadu"
/build-scripts/build-kakadu.sh

for x in `find /usr/local/bin /usr/local/lib /usr/local/lib64 -type f`; do
  strip "${x}" || true
done
