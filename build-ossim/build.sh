#!/bin/bash

set -e

./checkout-ossim.sh
docker run -it -v "${PWD}/ossim-repos:/work" -v "${PWD}/output:/output" ossim-builder:alpine /build_scripts/build-ossim.sh
