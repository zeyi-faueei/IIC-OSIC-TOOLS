#!/bin/bash

set -e

REPO_COMMIT_SHORT=$(echo "$YOSYS_REPO_COMMIT" | cut -c 1-7)

git clone --filter=blob:none "${YOSYS_REPO_URL}" "${YOSYS_NAME}"
cd "${YOSYS_NAME}"
git checkout "${YOSYS_REPO_COMMIT}"
make install -j"$(nproc)" PREFIX="${TOOLS}/${YOSYS_NAME}/${REPO_COMMIT_SHORT}" CONFIG=gcc
cd ..

export PATH=$PATH:${TOOLS}/${YOSYS_NAME}/${REPO_COMMIT_SHORT}/bin

# Install yosys eqy
git clone --filter=blob:none https://github.com/YosysHQ/eqy.git
cd eqy
sed -i "s#^PREFIX.*#PREFIX=${TOOLS}/${YOSYS_NAME}#g" Makefile
make install -j"$(nproc)"
cd ..

# Install yosys sby
git clone --filter=blob:none https://github.com/YosysHQ/sby.git
cd sby
sed -i "s#^PREFIX.*#PREFIX=${TOOLS}/${YOSYS_NAME}#g" Makefile
make install -j"$(nproc)" 
cd ..

# Install yosys mcy
git clone --filter=blob:none https://github.com/YosysHQ/mcy.git
cd mcy
sed -i "s#^PREFIX.*#PREFIX=${TOOLS}/${YOSYS_NAME}#g" Makefile
make install -j"$(nproc)"
cd ..
