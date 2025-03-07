#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=112
#SBATCH --threads-per-core=2
#SBATCH --qos=gp_bscls
#SBATCH --account=bsc08
#SBATCH -t 02:00:00
#SBATCH -o ./outputs/stat_prueba_th.log
#output-%j
#SBATCH -e ./outputs/stat_prueba_th.log
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
for threads in 56 112 113 150
do
	#export OMP_NUM_THREADS=$threads
	perf stat --per-thread -r 1 mpirun -n 1 ./tridiagonals_512 5000 10 2 1 $threads ./outputs/${threads}_threads.csv >> ./outputs/stats/prueba_th.log
done
