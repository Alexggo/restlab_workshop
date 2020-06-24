#!/bin/bash

#SBATCH --job-name=gcc_mpi_hello
#SBATCH --output=gcc_mpi_hello.log
#SBATCH --ntasks-per-node=28
#SBATCH --nodes=2
#SBATCH --time=05:00
#SBATCH -p short-28core


module load gcc-stack

mpirun ./gcc_mpi_hello 
