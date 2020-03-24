#!/bin/sh

cp ../build-ossim/output/ossim-dist.tgz ./
docker build -t ossim-runtime-minimal:alpine . 

