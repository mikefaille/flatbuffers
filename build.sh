#!/bin/bash
set -ex
rm -rf /app/build
mkdir -p /app/build
cd /app/build
cmake /app
cmake --build . -j8