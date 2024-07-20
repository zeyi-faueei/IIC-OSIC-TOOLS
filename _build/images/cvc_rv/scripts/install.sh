#!/bin/bash

set -e
set -u

git clone --filter=blob:none "${CVC_RV_REPO_URL}" "${CVC_RV_NAME}"
cd "${CVC_RV_NAME}"
git checkout "${CVC_RV_REPO_COMMIT}"
autoreconf -vif
./configure --disable-nls --prefix="${TOOLS}/${CVC_RV_NAME}"
make -j"$(nproc)"
make install
