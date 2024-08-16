#!/bin/bash
#
# Test if a few of the import Python packages work properly.

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! python "$DIR/pkgs.py" 
then
    echo "[ERROR] Test <Python-Packages> failed."
    exit 1
else
    echo "[INFO] Test <Python-Packages> passed."
    exit 0
fi
