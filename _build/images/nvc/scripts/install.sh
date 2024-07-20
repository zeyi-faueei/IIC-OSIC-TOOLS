#!/bin/bash

set -e

git clone --filter=blob:none "${NVC_REPO_URL}" "${NVC_NAME}"
cd "${NVC_NAME}"
git checkout "${NVC_REPO_COMMIT}"
./autogen.sh
mkdir build && cd build
../configure --prefix="${TOOLS}/${NVC_NAME}"
make -j"$(nproc)"
make install
