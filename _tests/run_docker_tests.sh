#!/bin/bash
# SPDX-FileCopyrightText: 2024 Harald Pretl
# Johannes Kepler University, Institute for Integrated Circuits
# SPDX-License-Identifier: Apache-2.0
#
# Run all tests (checks) in the subdirectories using a specified Docker image.

if [ $# -ne 1 ]; then
    echo "[ERROR] Please specify the image tag to test!"
    exit 1
fi

TAG=$1
CONTAINER_NAME=iic-osic-tools_test
CMD=_run_tests.sh
WORKDIR=/foss/designs

# Check if newer image is available and pull if needed
docker pull --quiet hpretl/iic-osic-tools:"$TAG" > /dev/null

# Create the test runner script
cat <<EOL > $CMD
#!/bin/bash
find $WORKDIR -type f -name "test*.sh" -exec parallel ::: {} \;
EOL
chmod +x $CMD

# Now run the actual tests
docker run -it --rm --name $CONTAINER_NAME --user 1000:1000 -e DISPLAY= -v "$PWD":$WORKDIR:rw hpretl/iic-osic-tools:"$TAG" -s "$WORKDIR/$CMD"

# Cleanup
rm -f $CMD
