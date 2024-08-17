#!/bin/bash
# SPDX-FileCopyrightText: 2024 Harald Pretl
# Johannes Kepler University, Institute for Integrated Circuits
# SPDX-License-Identifier: Apache-2.0
#
# Test if the smoke test of OpenLane2 runs successfully; if this works,
# many SW packages have to work properly, so this is a test with good
# coverage.
#
# We do this only for gf180mcuD for now.

RESULT=/tmp/result_ol_gf180mcud.log

# Switch to gf180mcuD PDK
# shellcheck source=/dev/null
unset STD_CELL_LIBRARY
source iic-pdk-script.sh gf180mcuD gf180mcu_fd_sc_mcu7t5v0 > /dev/null
# Run the OpenLane2 smoke test
openlane --smoke-test > $RESULT
# Check if there is an error in the log
if grep -q "ERROR" "$RESULT"; then
    echo "[ERROR] Test <OpenLane gf180mcuD> FAILED."
    exit 1
else
    echo "[INFO] Test <OpenLane gf180mcuD> passed."
    exit 0
fi
