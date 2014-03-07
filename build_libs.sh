#!/bin/bash

LIBS_DIR="libs"

DEPS="https://github.com/SolidCode/MCAD.git "

cd ${LIBS_DIR}
for lib_url in ${DEPS}; do
    git clone ${lib_url}
done
