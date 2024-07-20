#!/bin/bash

set -e

git clone --filter=blob:none "${COVERED_REPO_URL}" "${COVERED_NAME}"
cd "${COVERED_NAME}"
git checkout "${COVERED_REPO_COMMIT}"
./configure --prefix="${TOOLS}/${COVERED_NAME}"
make # -j$(nproc) Using the -j option leads to random fails on many-core machines
make install
