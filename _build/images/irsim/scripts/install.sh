#!/bin/bash

set -e

git clone --filter=blob:none "${IRSIM_REPO_URL}" "${IRSIM_NAME}"
cd "${IRSIM_NAME}"
git checkout "${IRSIM_REPO_COMMIT}"
./configure --prefix="${TOOLS}/${IRSIM_NAME}"
make -j"$(nproc)"
make install
