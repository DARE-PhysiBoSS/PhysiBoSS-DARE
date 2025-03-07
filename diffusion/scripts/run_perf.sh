#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=112
#SBATCH --threads-per-core=2
#SBATCH --qos=gp_debug
#SBATCH --account=bsc08
#SBATCH -t 2:00:00
#SBATCH -o counters.log
#output-%j
#SBATCH -e counters.log
#error-%j
#SBATCH --exclusive
#SBATCH --constraint=perfparanoid 


export OMP_DISPLAY_ENV=false
#export OMP_NUM_THREADS=48
export OMP_PROC_BIND=close
export OMP_PLACES=threads

module purge
module load gcc/13.2.0 openmpi/4.1.5-gcc


for threads in 112
do
	#export OMP_NUM_THREADS=$threads
	perf record -c 10000 -e cycles,faults,dTLB-load-misses  -o ./perf_data/tri_${threads}.data mpirun ./tridiagonals_512 5000 10 2 1 $threads ./outputs/${threads}_threads.csv 
done
