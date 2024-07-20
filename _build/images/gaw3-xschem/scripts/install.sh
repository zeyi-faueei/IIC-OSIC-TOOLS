#!/bin/bash

set -e

git clone --filter=blob:none "${GAW3_XSCHEM_REPO_URL}" "${GAW3_XSCHEM_NAME}"
cd "${GAW3_XSCHEM_NAME}"
git checkout "${GAW3_XSCHEM_REPO_COMMIT}"
chmod +x configure
autoreconf -f -i
./configure --prefix="${TOOLS}/${GAW3_XSCHEM_NAME}"
make -j"$(nproc)"
make install
