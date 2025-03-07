#!/bin/bash

source /apps/GPP/BSCTOOLS/extrae/4.2.0/openmpi_4_1_5_gcc/etc/extrae.sh

export OMP_NUM_THREADS=112
export EXTRAE_CONFIG_FILE=./extrae.xml
export LD_PRELOAD=${EXTRAE_HOME}/lib/libompitrace.so # For C apps
#export LD_PRELOAD=${EXTRAE_HOME}/lib/libompitracef.so # For Fortran apps

## Run the desired program
$*

