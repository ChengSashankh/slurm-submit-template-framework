#!/bin/sh

#SBATCH --job-name=$$JOB_NAME$$
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=cksash@comp.nus.edu.sg
#SBATCH --gpus=1
#SBATCH --partition=$$PARTITION_TYPE$$

srun run-training.sh $$REPO_PATH$$