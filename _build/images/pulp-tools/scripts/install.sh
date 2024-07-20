#!/bin/bash

set -e

mkdir -p "${TOOLS}/${PULP_NAME}/bin"

# Build Bender
# ------------
git clone --depth=1 https://github.com/pulp-platform/bender.git
cd bender || exit
cargo build --release -j"$(nproc)"
cp target/release/bender "${TOOLS}/${PULP_NAME}/bin"
cd ..

# Build Morty
# -----------
git clone --depth=1 https://github.com/pulp-platform/morty.git 
cd morty || exit
cargo build --release -j"$(nproc)"
cp target/release/morty "${TOOLS}/${PULP_NAME}/bin"
cd ..

# Build SVase
# -----------
git clone --depth=1 https://github.com/pulp-platform/svase.git
cd svase || exit
make build -j"$(nproc)"
cp build/svase "${TOOLS}/${PULP_NAME}/bin"
cd ..
