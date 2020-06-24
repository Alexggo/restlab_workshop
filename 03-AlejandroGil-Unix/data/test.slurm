#!/bin/bash

#SBATCH --job-name=test
#SBATCH --output=test.txt
#SBATCH --ntasks-per-node=28
#SBATCH --nodes=1
#SBATCH --time=05:00
#SBATCH -p short-28core


echo "This is just a test"
