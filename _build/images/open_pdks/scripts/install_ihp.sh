#!/bin/bash
set -e
cd /tmp || exit 1

if [ ! -d "$PDK_ROOT" ]; then
    mkdir -p "$PDK_ROOT"
fi

####################
# INSTALL IHP-SG13G2
####################

IHP_PDK="ihp-sg13g2"
MY_PDK="ihp-sg13g2"

#FIXME don't do a shallow clone until we work on the dev branch
#git clone --depth=1 https://github.com/IHP-GmbH/IHP-Open-PDK.git ihp
git clone https://github.com/IHP-GmbH/IHP-Open-PDK.git ihp
cd ihp || exit 1
#FIXME for now uses branch "dev" to get the latest releases
git checkout dev
git submodule update --init --recursive

# Now move to the proper location
if [ -d $IHP_PDK ]; then
	mv $IHP_PDK "$PDK_ROOT/$MY_PDK"
fi

####################
# Compile .va models
####################
cd "$PDK_ROOT"/"$MY_PDK"/libs.tech/ngspice/openvaf || exit 1

"$TOOLS/$OPENVAF_NAME/bin/openvaf" --target_cpu generic psp103_nqs.va
