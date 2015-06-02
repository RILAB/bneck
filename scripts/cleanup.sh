#!/bin/bash -l
#SBATCH -D /home/jri/projects/bneck
#SBATCH -J cleanup
#SBATCH -o outs/out-%A.%a.txt
#SBATCH -e errors/error-%A.%a.txt

module load libsequence
cd outs
for i in out-"$1".*; do ../scripts/split.pl $i; 
done
cat neutral."$1".*.txt > neutral_sims.$1
cat selected."$1".*.txt > selected_sims.$1
rm selected."$1".*.txt
rm neutral."$1".*.txt
rm out-"$1".*.txt
