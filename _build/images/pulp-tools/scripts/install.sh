#!/bin/bash

#set -e

mkdir -p "${TOOLS}/${PULP_NAME}/bin"
cd /tmp || exit

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

# Install Verible
# ---------------
# We don't build locally (too many strange dependencies), but get binary
if [ "$(arch)" == "aarch64" ]; then
    CPUID="arm64"
else
    CPUID="x86_64"
fi
LOC=https://github.com/chipsalliance/verible/releases/download/v0.0-3724-gdec56671
FILE=verible-v0.0-3724-gdec56671-linux-static-${CPUID}.tar.gz
wget --no-verbose $LOC/$FILE && tar xfz $FILE && rm -f $FILE
cp verible*/bin/* "${TOOLS}/${PULP_NAME}/bin"

# Build SV2V
# ----------
# Get Haskell stack first
wget -qO- https://get.haskellstack.org/ | sh
# Now build SV2V using Haskell and Stack
git clone --depth=1 https://github.com/zachjs/sv2v.git
cd sv2v || exit
stack install --install-ghc --local-bin-path bin --stack-root /tmp/stack
cp bin/sv2v "${TOOLS}/${PULP_NAME}/bin"
cd ..
