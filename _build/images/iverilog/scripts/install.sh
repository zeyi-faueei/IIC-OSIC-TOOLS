#!/bin/bash

set -e

git clone --filter=blob:none "${IVERILOG_REPO_URL}" "${IVERILOG_NAME}"
cd "${IVERILOG_NAME}"
git checkout "${IVERILOG_REPO_COMMIT}"
chmod +x autoconf.sh
./autoconf.sh
./configure --prefix="${TOOLS}/${IVERILOG_NAME}"
make -j"$(nproc)"
make install
