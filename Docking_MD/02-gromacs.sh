#!/bin/bash
#SBATCH -J xxx # Job Name
#SBATCH -N 5 # Number of Nodes
#SBATCH --ntasks-per-node=xx # Number of tasks per node
#SBATCH -p kshcnormal

module purge
source /public/home/hcao/apprepo/gromacs/2024.1-gcc930_intelmpi2017/scripts/env.sh

## Assume that the tpr file is named md_0_100.tpr

mpirun -np $SLURM_NTASKS gmx_mpi mdrun -ntomp 1 -v -deffnm md_0_100
