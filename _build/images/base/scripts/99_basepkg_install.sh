#!/bin/bash

set -e

echo "[INFO] Install Jupyter packages via PIP"
pip3 install --upgrade --no-cache-dir \
	jupyter \
	jupyterlab \
	jupyter-collaboration \
	jupyterlab-night

#FIXME Adding simplesat with version 0.8.0 to fix fail on arm64
echo "[INFO] Install EDA packages via PIP"
pip3 install --upgrade --no-cache-dir \
	amaranth==0.5.2 \
	cace==2.4.14 \
	cocotb==1.9.1 \
	edalize==0.5.4 \
	fusesoc==2.3 \
	gdsfactory==8.8.5 \
	gdspy==1.6.13 \
	openlane==2.1.3 \
	openram==1.2.48 \
	pygmid==1.2.12 \
	pyrtl==0.11.2 \
	pyspice==1.5 \
	pyuvm==3.0.0 \
	pyverilog==1.3.0 \
	schemdraw[svgmath]==0.19 \
	scikit-rf==1.3.0 \
	siliconcompiler==0.27.1 \
	simplesat==0.8.0 \
	spyci==1.0.2 \
	volare==0.19.1

echo "[INFO] Install EDA packages via GEM"
gem install \
	rggen \
	rggen-verilog \
	rggen-vhdl
