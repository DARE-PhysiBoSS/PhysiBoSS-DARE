#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=112
#SBATCH --threads-per-core=2
#SBATCH --qos=gp_bscls
#SBATCH --account=bsc08
#SBATCH -t 2-00:00:00
#SBATCH -o avx256.log
#output-%j
#SBATCH -e avx256.log
#error-%j
#SBATCH --exclusive


export OMP_DISPLAY_ENV=false
#export OMP_NUM_THREADS=48
export OMP_PROC_BIND=close
export OMP_PLACES=threads

module purge
module load gcc/13.2.0 openmpi/4.1.5-gcc

#Small side 2000 substrates 1

#export OMP_NUM_THREADS=$threads
srun --cpus-per-task=112 --threads-per-core=2 ./tridiagonals 1000 10 2 1 112 ./avx256/page.csv #1> small.log 2> small.log 
#Medium 5000 subs 2

#Large 10000 subs 4

#Extra large side 14000 subs 8

#Massive side 20000 subs 8
