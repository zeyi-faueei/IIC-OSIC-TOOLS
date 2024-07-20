#!/bin/bash

set -e

git clone --filter=blob:none "${VERILATOR_REPO_URL}" "${VERILATOR_NAME}"
cd "${VERILATOR_NAME}"
git checkout "${VERILATOR_REPO_COMMIT}"
autoconf
unset VERILATOR_ROOT
./configure --prefix="${TOOLS}/${VERILATOR_NAME}"
make -j"$(nproc)"
make install
