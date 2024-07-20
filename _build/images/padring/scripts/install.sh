#!/bin/bash

set -e

git clone --filter=blob:none "${PADRING_REPO_URL}" "${PADRING_NAME}"
cd "${PADRING_NAME}"
git checkout "${PADRING_REPO_COMMIT}"
bash ./bootstrap.sh
cd build
ninja
mkdir -p "${TOOLS}/${PADRING_NAME}/bin"
cp padring "${TOOLS}/${PADRING_NAME}/bin"
