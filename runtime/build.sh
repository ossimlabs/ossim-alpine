#!/bin/sh

tar -cvz -C ../dist -f ossim-dist.tgz .
docker build -t ossim-runtime-alpine-minimal:local . 

