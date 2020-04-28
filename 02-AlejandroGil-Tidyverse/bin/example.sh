#!/bin/bash

#SBATCH --job-name=NAME
#SBATCH -o LOGOUT.sh.out
#SBATCH --nodes=1
#SBATCH -p short-28core
#SBATCH --time=04:00:00

### SET WD
cd /gpfs/projects/RestGroup/alex/ch3_repo/bin

### LOAD MODULES
module load shared
module load git
#module load anaconda/2

### LOAD ENVIRONMENT
#source activate ___


### SCRIPT
#Rscript name.R
