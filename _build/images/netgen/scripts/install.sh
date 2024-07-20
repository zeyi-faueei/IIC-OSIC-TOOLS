#!/bin/bash

set -e

git clone --filter=blob:none "${NETGEN_REPO_URL}" "${NETGEN_NAME}"
cd "${NETGEN_NAME}"
git checkout "${NETGEN_REPO_COMMIT}"
./configure CFLAGS="-O2 -g" --prefix="${TOOLS}/${NETGEN_NAME}"
make clean
make -j"$(nproc)"
make install
