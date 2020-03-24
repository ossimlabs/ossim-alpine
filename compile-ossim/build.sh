#!/bin/bash

set -e

./checkout-ossim.sh
docker run -it \
-v "${PWD}/build-scripts/build-ossim.sh:/build_scripts/build-ossim.sh" \
-v "${PWD}/build-scripts/build-joms.sh:/build_scripts/build-joms.sh" \
-v "${PWD}/ossim-repos:/work" \
-v "${PWD}/output:/output" \
ossim-builder:alpine
