#!/bin/bash

set -e

git clone --filter=blob:none "${KLAYOUT_REPO_URL}" "${KLAYOUT_NAME}"
cd "${KLAYOUT_NAME}"
git checkout "${KLAYOUT_REPO_COMMIT}"
prefix=${TOOLS}/${KLAYOUT_NAME}
mkdir -p "$prefix"
./build.sh -j"$(nproc)" -prefix "$prefix" -without-qtbinding
