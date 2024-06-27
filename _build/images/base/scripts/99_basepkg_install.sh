#!/bin/bash

set -e

echo "[INFO] Install Jupyter packages via PIP"
pip3 install --upgrade --no-cache-dir \
	jupyter \
	jupyterlab \
	jupyter-collaboration \
	jupyterlab-night

echo "[INFO] Install EDA packages via PIP"
pip3 install --upgrade --no-cache-dir \
	amaranth==0.5.0 \
	cace==2.3.7 \
	cocotb==1.8.1 \
	edalize==0.5.4 \
	fusesoc==2.3 \
	gdsfactory==8.3.1 \
	gdspy==1.6.13 \
	hdl21==6.0.0 \
	openram==1.2.48 \
	pyrtl==0.11.1 \
	pyspice==1.5 \
	pyuvm==2.9.1 \
	pyverilog==1.3.0 \
	schemdraw==0.19 \
	scikit-rf==1.1.0 \
	siliconcompiler==0.23.3 \
	spyci==1.0.2 \
	vlsirtools==6.0.0 \
	volare==0.18.0

#FIXME openlane==2.0.10 \
#FIXME Locally build OpenLane2 due to klayout incompatibility
cd /tmp
git clone --depth=1 https://github.com/iic-jku/openlane2.git
cd openlane2
pip3 install .
cd /


echo "[INFO] Install EDA packages via GEM"
gem install \
	rggen \
	rggen-verilog \
	rggen-vhdl

echo "[INFO] Install EDA packages via NPM"
npm install -g \
	netlistsvg
