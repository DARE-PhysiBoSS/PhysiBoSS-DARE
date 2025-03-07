#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=112
#SBATCH --threads-per-core=2
#SBATCH --qos=gp_bscls
#SBATCH --account=bsc08
#SBATCH -t 20:00:00
#SBATCH -o output-%j
#SBATCH -e error-%j
#SBATCH --exclusive
#SBATCH --constraint=perfparanoid 


export OMP_DISPLAY_ENV=true
export OMP_NUM_THREADS=112
export OMP_PROC_BIND=close
export OMP_PLACES=threads



export nodes=1

module purge
module load gcc/13.2.0 openmpi/4.1.5-gcc

echo "Executing $1"

#XS 
voxels=2000
substrates=1
for factor in 1 2 4 6 8 12 16 20 24 32
do
	overlap=$((nodes * factor))
	echo "Executing Side: ${voxels} | Substrates: ${substrates} | Steps: ${overlap}"
	srun --nodes=1 --ntasks-per-node=1 --cpus-per-task=112 --threads-per-core=2 ./$1 $voxels 10 $substrates $overlap 112 ./multinode/${1}/xs/factor_${factor}/${nodes}_node.csv 1> ./multinode/${1}/xs/factor_${factor}/${nodes}_node.log 2> ./multinode/${1}/xs/factor_${factor}/${nodes}_node.log
done
#S
voxels=5000
substrates=2
for factor in 1 2 4 6 8 12 16 20 24 32
do
	overlap=$((nodes * factor))
	echo "Executing Side: ${voxels} | Substrates: ${substrates} | Steps: ${overlap}"
	srun --nodes=1 --ntasks-per-node=1 --cpus-per-task=112 --threads-per-core=2 ./$1 $voxels 10 $substrates $overlap 112 ./multinode/${1}/s/factor_${factor}/${nodes}_node.csv 1> ./multinode/${1}/s/factor_${factor}/${nodes}_node.log 2> ./multinode/${1}/s/factor_${factor}/${nodes}_node.log
done

#M
voxels=10000
substrates=4

for factor in 1 2 4 6 8 12 16 20 24 32
do
	overlap=$((nodes * factor))
	echo "Executing Side: ${voxels} | Substrates: ${substrates} | Steps: ${overlap}"
	srun --nodes=1 --ntasks-per-node=1 --cpus-per-task=112 --threads-per-core=2 ./$1 $voxels 10 $substrates $overlap 112 ./multinode/${1}/m/factor_${factor}/${nodes}_node.csv 1> ./multinode/${1}/m/factor_${factor}/${nodes}_node.log 2> ./multinode/${1}/m/factor_${factor}/${nodes}_node.log
done

#L
voxels=15000
substrates=8
for factor in 1 2 4 6 8 12 16 20 24 32
do
	overlap=$((nodes * factor))
	echo "Executing Side: ${voxels} | Substrates: ${substrates} | Steps: ${overlap}"
	srun --nodes=1 --ntasks-per-node=1 --cpus-per-task=112 --threads-per-core=2 ./$1 $voxels 10 $substrates $overlap 112 ./multinode/${1}/l/factor_${factor}/${nodes}_node.csv 1> ./multinode/${1}/l/factor_${factor}/${nodes}_node.log 2> ./multinode/${1}/l/factor_${factor}/${nodes}_node.log
done
#XL
voxels=20000
substrates=8
for factor in 1 2 4 6 8 12 16 20 24 32
do
	overlap=$((nodes * factor))
	echo "Executing Side: ${voxels} | Substrates: ${substrates} | Steps: ${overlap}"
	srun --nodes=1 --ntasks-per-node=1 --cpus-per-task=112 --threads-per-core=2 ./$1 $voxels 10 $substrates $overlap 112 ./multinode/${1}/xl/factor_${factor}/${nodes}_node.csv 1> ./multinode/${1}/xl/factor_${factor}/${nodes}_node.log 2> ./multinode/${1}/xl/factor_${factor}/${nodes}_node.log
done
#XXL
voxels=25000
substrates=8
for factor in 1 2 4 6 8 12 16 20 24 32
do
	overlap=$((nodes * factor))
	echo "Executing Side: ${voxels} | Substrates: ${substrates} | Steps: ${overlap}"
	srun --nodes=1 --ntasks-per-node=1 --cpus-per-task=112 --threads-per-core=2 ./$1 $voxels 10 $substrates $overlap 112 ./multinode/${1}/xxl/factor_${factor}/${nodes}_node.csv 1> ./multinode/${1}/xxl/factor_${factor}/${nodes}_node.log 2> ./multinode/${1}/xxl/factor_${factor}/${nodes}_node.log
done


		
	
