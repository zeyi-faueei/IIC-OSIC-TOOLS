#!/bin/bash
# SPDX-FileCopyrightText: 2024 Harald Pretl
# Johannes Kepler University, Institute for Integrated Circuits
# SPDX-License-Identifier: Apache-2.0
#
# Smoke test for the following tools:
# - bender: https://github.com/pulp-platform/bender
# - morty:  https://github.com/pulp-platform/morty
# - svase:  https://github.com/pulp-platform/svase
# - sv2v:   https://github.com/zachjs/sv2v

# test if a command finishes successfully
test() {
    local cmd="$1"
    echo "Running: $cmd"
    eval "$cmd" &>> $LOG
    if [ $? -ne 0 ]; then
        echo "[ERROR] '$cmd' failed" >> $LOG
    fi
    echo -e "\n\n\n" >> $LOG
}

# test if a command fails
test_fail() {
    local cmd="$1"
    echo "Running: $cmd"
    eval "$cmd" &>> $LOG
    if [ $? -eq 0 ]; then
        echo "[ERROR] '$cmd' was expected to fail but succeeded" >> $LOG
    else
        echo "[INFO] '$cmd' failed as expected" >> $LOG
    fi
    echo -e "\n\n\n" >> $LOG
}

TMP=/tmp/test_08
LOG=$TMP/tools.log
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


if [ -d $TMP ]; then
    rm -rf $TMP/*
else 
    mkdir $TMP
fi

cp $DIR/Bender.yml $TMP/
cp $DIR/*.sv       $TMP/
cd $TMP/

echo "Testing bender..."
{
    test "bender update"
    test "bender checkout"
    test "bender sources -f > error.json"
    test "bender sources -f -t test_target > top.json"
} &> $LOG

echo "Testing morty..."
{
    test_fail "morty -q -f error.json -o error_morty.sv"
    test "morty -q -f top.json -o top_morty.sv"
    test "morty -q -f top.json -D ERROR -o error_morty.sv"
} &> $LOG

echo "Testing svase..."
{
    test_fail "svase top error_svase.sv error_morty.sv"
    test "svase top top_svase.sv top_morty.sv"
} &> $LOG

echo "Testing sv2v..."
{
    test "sv2v --write top_sv2v.v top_svase.sv"
    test "yosys -Q -q -p \"read_verilog top_sv2v.v; synth;\""
} &> $LOG


if grep -q "\[ERROR\]" $LOG; then
    echo "PULP-flow smoke test ERRORS. Check log at $LOG"
    exit 1
else
    echo "PULP-flow smoke test completed successfully."
    exit 0
fi