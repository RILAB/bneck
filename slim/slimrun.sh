#!/bin/bash -l
#SBATCH -D /home/jri/projects/bneck/slim
#SBATCH -J shady
#SBATCH -o ../outs/out-%A.%a.txt
#SBATCH -p serial
#SBATCH --array=1-100
#SBATCH -e ../errors/error-%A.%a.txt

INPUT=$1

/home/jri/src/slim/slim $INPUT
