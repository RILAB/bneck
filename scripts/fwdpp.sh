#!/bin/bash -l
#SBATCH -D /home/jri/projects/bneck
#SBATCH -J fwdpp
#SBATCH -o outs/out-%A.%a.txt
#SBATCH --array=1-100
#SBATCH -e errors/error-%A.%a.txt

module load libsequence

seed=$(( $SLURM_ARRAY_TASK_ID*$RANDOM ))
N=15000
neutral_theta=12
selected_theta=24
rho=$(( $neutral_theta + $selected_theta ))
s=$1 #selection <- CHECK WHICH VERSION OF CODE YOU ARE USING. s is either fixed s or mean of exponential!
pp=0.001 #proportion of selected mutations that are positively selected
h=0.01 #dominance
g1=150000 #generations between N and N2?
N2=12000 #bneck size
N3=1500000 #new NE at end
n=23 #number samples
g2=90
nreps=1

if [[ -z $h || -z $s ]]; then exit 1; fi

cat scripts/fwdpp.sh 1>&2
~/src/fwdpp/examples/bneck_selection_dist $N $neutral_theta $selected_theta $rho $s $pp $h $g1 $N2 $N3 $g2 $n $nreps $seed #> temp/out.$SLURM_ARRAY_JOB_ID.$SLURM_ARRAY_TASK_ID.txt  

#~/src/fwdpp/examples/bneck_selection $N $neutral_theta $selected_theta $rho $s $h $g1 $N2 $N3 $g2 $n $nreps $seed > temp/out.$SLURM_ARRAY_JOB_ID.$SLURM_ARRAY_TASK_ID.txt  

