#!/bin/bash


for node in  2 4 8 12 16 24 32 48 64 80 96
do
    sbatch run_${node}.sh novector
    sbatch run_${node}.sh tridiagonals
    sbatch run_${node}.sh tridiagonals_512
done
