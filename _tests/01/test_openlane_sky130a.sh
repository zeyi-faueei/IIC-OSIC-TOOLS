#!/bin/bash
#
# Test if the smoke test of OpenLane2 runs successfully; if this works,
# many SW packages have to work properly, so this is a test with good
# coverage.
#
# We do this only for sky130A for now.

RESULT=/tmp/result_ol_sky130a.log

# Switch to sky130A PDK
# shellcheck source=/dev/null
source iic-pdk-script.sh sky130A > /dev/null
# Run the OpenLane2 smoke test
openlane --smoke-test > $RESULT
# Check if there is an error in the log
if grep -q "ERROR" "$RESULT"; then
    echo "[ERROR] Test <OpenLane> failed."
    exit 1
else
    echo "[INFO] Test <OpenLane> passed."
    exit 0
fi
