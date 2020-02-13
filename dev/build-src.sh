#!/bin/bash 

for x in build-proj.sh build-geotiff.sh build-geos.sh build-kakadu.sh build-gdal.sh build-ossim.sh build-joms.sh; do
  /scripts/$x
done

for x in `find /usr/local/bin -type f`; do
  strip $x
done

for x in `find /usr/local/lib -type f`; do
  strip $x
done

for x in `find /usr/local/lib64 -type f`; do
  strip $x
done
