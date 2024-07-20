#!/bin/bash

set -e

git clone --filter=blob:none "${MAGIC_REPO_URL}" "${MAGIC_NAME}"
cd "${MAGIC_NAME}"
git checkout "${MAGIC_REPO_COMMIT}"
./configure --prefix="${TOOLS}/${MAGIC_NAME}"
make database/database.h
make -j"$(nproc)"
make install

echo "$MAGIC_NAME $MAGIC_REPO_COMMIT" > "${TOOLS}/${MAGIC_NAME}/SOURCES"
