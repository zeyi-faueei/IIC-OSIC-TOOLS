#!/bin/bash

set -e

git clone --filter=blob:none "${SURELOG_REPO_URL}" "${SURELOG_NAME}"
cd "${SURELOG_NAME}"
git checkout "${SURELOG_REPO_COMMIT}"
git submodule update --init --recursive
make -j"$(nproc)"
make install PREFIX="${TOOLS}/${SURELOG_NAME}"
