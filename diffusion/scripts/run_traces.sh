#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=112
#SBATCH --threads-per-core=2
#SBATCH --qos=gp_debug
#SBATCH --account=bsc08
#SBATCH -t 2:00:00
#SBATCH -o output-%j
#SBATCH -e error-%j
#SBATCH --exclusive
#SBATCH --constraint=perfparanoid 


export OMP_DISPLAY_ENV=true
export OMP_NUM_THREADS=112
export OMP_PROC_BIND=close
export OMP_PLACES=threads


module purge
module load gcc/13.2.0 openmpi/4.1.5-gcc

#srun --nodes=2 --ntasks-per-node=1 --cpus-per-task=112 --threads-per-core=2
srun --nodes=1 --ntasks-per-node=1 --cpus-per-task=112 --threads-per-core=2 ./trace.sh ./tridiagonals 1000 10 1 1 114 /dev/null 
/apps/GPP/BSCTOOLS/extrae/4.2.0/openmpi_4_1_5_gcc/bin/mpi2prv -f TRACE.mpits -o ./traces/tridiagonals.prv.gz
