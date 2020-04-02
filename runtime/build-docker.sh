#!/bin/sh

cp ../compile-ossim/output/ossim-dist-minimal-alpine.tgz ./
docker build -t ossim-runtime-minimal-alpine:local . 

