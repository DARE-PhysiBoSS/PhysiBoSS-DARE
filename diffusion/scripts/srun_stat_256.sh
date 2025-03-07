#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=112
#SBATCH --threads-per-core=2
#SBATCH --qos=gp_bscls
#SBATCH --account=bsc08
#SBATCH -t 2:00:00
#SBATCH -o ./perf_data/srun_256.log
#output-%j
#SBATCH -e ./perf_data/srun_256.log
#error-%j
#SBATCH --exclusive
#SBATCH --constraint=perfparanoid 


export OMP_DISPLAY_ENV=false
#export OMP_NUM_THREADS=48
export OMP_PROC_BIND=close
export OMP_PLACES=threads

module purge
module load gcc/13.2.0 openmpi/4.1.5-gcc

#56 112 113 150 200 214 224
for threads in 56 112 113 114 150 200 214 224
do
	#export OMP_NUM_THREADS=$threads
	perf stat -d -d -d -r 10  srun --cpus-per-task=112 --threads-per-core=2 ./tridiagonals 5000 10 2 1 $threads ./outputs/${threads}_threads.csv >> ./perf_data/256.log
done
