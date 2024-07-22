#!/bin/bash

set -e

git clone --filter=blob:none "$RISCV_GNU_TOOLCHAIN_RV32I_REPO_URL" "$RISCV_GNU_TOOLCHAIN_RV32I_NAME"
cd "$RISCV_GNU_TOOLCHAIN_RV32I_NAME"
git checkout "$RISCV_GNU_TOOLCHAIN_RV32I_REPO_COMMIT"
#git submodule update --init --recursive
mkdir build && cd build
../configure --with-arch=rv32iac --prefix="${TOOLS}/$RISCV_GNU_TOOLCHAIN_RV32I_NAME"
make linux -j"$(nproc)"
