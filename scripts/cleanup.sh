#!/bin/bash -l
#SBATCH -D /home/jri/projects/bneck
#SBATCH -J cleanup
#SBATCH -o outs/out-%A.%a.txt
#SBATCH -e errors/error-%A.%a.txt
#SBATCH -p bigmem

module load libsequence
cd temp
for i in out.*; do ../scripts/split.pl $i; done
for i in selected.*; do cat $i | msstats > ../results/$i.stats; done
for i in neutral.*; do cat $i | msstats > ../results/$i.stats; done
