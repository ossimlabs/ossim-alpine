#!/bin/bash
set -e

BASE_DIR="${PWD}"
DEPS_DIR="${PWD}/deps"


docker build "$@" -t "ossim-alpine-builder:local" .
