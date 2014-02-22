#!/bin/bash -l
#SBATCH -D /home/jri/projects/bneck
#SBATCH -J fwdpp
#SBATCH -o outs/out-%A.%a.txt
#SBATCH --array=1-1000
#SBATCH -e errors/error-%A.%a.txt

module load libsequence

seed=$(( $SLURM_ARRAY_TASK_ID*$RANDOM ))
N=15000
neutral_theta=6
rho=$neutral_theta
selected_theta=12
s=$1 #selection
h=$2 #dominance
g1=150000 #generations between N and N2?
N2=15000 #bneck size
N3=15000 #new NE at end
n=20 #number samples
g2=900
nreps=1

if [[ -z $h || -z $s ]]; then exit 1; fi

cat scripts/fwdpp.sh 1>&2
~/src/fwdpp/examples/bneck_selection $N $neutral_theta $selected_theta $rho $s $h $g1 $N2 $N3 $g2 $n $nreps $seed  > temp/out.$SLURM_ARRAY_JOB_ID.$SLURM_ARRAY_TASK_ID

