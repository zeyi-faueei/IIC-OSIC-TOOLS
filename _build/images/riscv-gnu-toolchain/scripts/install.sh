#!/bin/bash

set -e

git clone --filter=blob:none "$RISCV_GNU_TOOLCHAIN_REPO_URL" "$RISCV_GNU_TOOLCHAIN_NAME"
cd "$RISCV_GNU_TOOLCHAIN_NAME"
git checkout "$RISCV_GNU_TOOLCHAIN_REPO_COMMIT"
#git submodule update --init --recursive
mkdir build && cd build
../configure --enable-multilib --prefix="${TOOLS}/$RISCV_GNU_TOOLCHAIN_NAME"
make linux -j"$(nproc)"
