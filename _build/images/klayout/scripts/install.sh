#!/bin/bash
set -e
cd /tmp || exit 1

git clone --filter=blob:none "${KLAYOUT_REPO_URL}" "${KLAYOUT_NAME}"
cd "${KLAYOUT_NAME}" || exit 1
git checkout "${KLAYOUT_REPO_COMMIT}"
#FIXME Apply patch to fix https://github.com/KLayout/klayout/issues/1930 until it is rolled into release
sed -i 's/char m_line/int m_line/' src/laybasic/laybasic/layMarker.h
#FIXME
prefix=${TOOLS}/${KLAYOUT_NAME}
mkdir -p "$prefix"
./build.sh -j"$(nproc)" -prefix "$prefix" -without-qtbinding
