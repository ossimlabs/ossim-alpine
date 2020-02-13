#!/bin/bash

WORK_DIR=$PWD/../work
DIST_DIR=$PWD/../dist

mkdir -p $WORK_DIR
mkdir -p $DIST_DIR

cd $WORK_DIR

for x in checkout-gdal.sh checkout-geos.sh checkout-geotiff.sh  checkout-kakadu.sh checkout-ossim.sh checkout-proj.sh; do
  ../dev/$x
done
