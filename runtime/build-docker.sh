#!/bin/sh

ln ../compile-ossim/output/ossim-dist-minimal-alpine.tgz ./
docker build -t ossim-runtime-minimal-alpine:local . 

