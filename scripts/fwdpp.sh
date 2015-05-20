#!/bin/bash -l
#SBATCH -D /home/jri/projects/bneck
#SBATCH -J fwdpp
#SBATCH -o outs/out-%A.%a.txt
#SBATCH --array=1-1000
#SBATCH -e errors/error-%A.%a.txt

module load libsequence/1.8.3

#This program simulates a population for g generations at size N. In generation g+1, N changes to N2 <= N. The population then grows exponentially to size N3 >= N2 in g2 generations. Selected and neutral mutations are allowed each generation. The output is in “ms” format--one block for neutral mutations followed by one block for selected mutations.

seed=$(( $SLURM_ARRAY_TASK_ID*$RANDOM ))
N=1230
neutral_theta=1500 #mu per bp 3E-7, 10kb, N=12,000
selected_theta=110 #3/4 of sites are selected, 1Kb of coding, otherwise same as above
rho=6500 #4 times neutral theta over 11kb region -- old:  $(( 4*($neutral_theta + $selected_theta) ))
s=$1 #selection <- CHECK WHICH VERSION OF CODE YOU ARE USING. s is either fixed s or mean of exponential!
pp=0.000 #proportion of selected mutations that are positively selected #no longer used
h=0.01 #dominance
g1=12300 #generations between N and N2?
N2=1230 #bneck size
N3=1230 #new NE at end
n=13 #number samples
g2=150
nreps=1
split=0 #0 combines neutral and selected SNPs in one ms block; 1 splits them into two blocks. changing this changes the downstream scripts/commands that need to be run
if [[ -z $h || -z $s ]]; then exit 1; fi

cat scripts/fwdpp.sh 1>&2
~/src/fwdpp/examples/bneck_selection_ind $N $neutral_theta $selected_theta $rho $s $h $g1 $N2 $N3 $g2 $n $nreps $seed #> temp/out.$SLURM_ARRAY_JOB_ID.$SLURM_ARRAY_TASK_ID.txt  

#~/src/fwdpp/examples/bneck_selection $N $neutral_theta $selected_theta $rho $s $h $g1 $N2 $N3 $g2 $n $nreps $seed > temp/out.$SLURM_ARRAY_JOB_ID.$SLURM_ARRAY_TASK_ID.txt  

