#!/bin/bash -l
#SBATCH -D /home/jri/projects/bneck
#SBATCH -J cleanup
#SBATCH -o outs/out-%A.%a.txt
#SBATCH -e errors/error-%A.%a.txt
#SBATCH -p bigmem

module load libsequence
cd outs
for i in out-"$1".*; do ../scripts/split.pl $i; done
for i in selected."$1".*; do cat $i | msstats | tail -n 1 > ../temp/$i.stats; done
cat ../temp/selected."$1".*stats > ../results/selected.$1
for i in neutral."$1".*; do cat $i | msstats | tail -n 1 > ../temp/$i.stats; done
cat ../temp/neutral."$1".*stats > ../results/neutral.$1
