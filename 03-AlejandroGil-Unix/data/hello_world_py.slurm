#!/bin/bash

#SBATCH --job-name=py_hello
#SBATCH --output=py_hello.log
#SBATCH --ntasks-per-node=28
#SBATCH --nodes=1
#SBATCH --time=05:00
#SBATCH -p short-28core

module load anaconda/3


mpirun python hello_world.py
