#!/bin/bash

set -e

git clone --filter=blob:none "${XSCHEM_REPO_URL}" "${XSCHEM_NAME}"
cd "${XSCHEM_NAME}"
git checkout "${XSCHEM_REPO_COMMIT}"
./configure --prefix="${TOOLS}/${XSCHEM_NAME}"
make -j"$(nproc)"
make install
