#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=112
#SBATCH --qos=gp_bscls
#SBATCH --account=bsc08
#SBATCH -t 1-00:00:00
#SBATCH -o small.log
#output-%j
#SBATCH -e small.log
#error-%j
#SBATCH --exclusive


export OMP_DISPLAY_ENV=false
#export OMP_NUM_THREADS=48
export OMP_PROC_BIND=close
export OMP_PLACES=threads

module purge
module load gcc/13.2.0 


#Small side 2000 substrates 1
for threads in {1..224}
do
	export OMP_NUM_THREADS=$threads
	./test_VS 1000 1 ./timing_mn5/s/${threads}_threads.csv #1> small.log 2> small.log
done 
#Medium 5000 subs 2

#Large 10000 subs 4

#Extra large side 14000 subs 8

#Massive side 20000 subs 8
