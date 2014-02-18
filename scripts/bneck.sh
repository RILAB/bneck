#!/bin/bash -l
#SBATCH -D /home/jri/projects/bneck
#SBATCH -J bneck
#SBATCH -o outs/out-%A.%a.txt
#SBATCH -p serial
#SBATCH --array=1-100
#SBATCH -e errors/error-%A.%a.txt

module load libsequence

N=100000 # wild Ne
t_recover=1 # generations since recovery
mu=$(echo "3*10 ^ -8" | bc -l) # mutation rate
region=100000 # length of region
theta=$( echo "4*$N*$mu*$region" | bc -l ) # assume rho = theta
bneck_N=10500 # Ne during bneck
bneck_dur=6000 # generations
alpha=$( echo "-(1/(($bneck_dur)/(4*$N)))*l($bneck_N/$N)" | bc -l ) # growth rate
n1=100 # sampled chroms from each pop
n2=100

seed="$RANDOM $RANDOM $RANDOM"

echo "N t_recover mu region theta bneck_N bneck_dur alpha n1 n2" 1>&2
echo "$N $t_recover $mu $region $theta $bneck_N $bneck_dur $alpha $n1 $n2" 1>&2

#3 epoch model
#echo "ms $(( $n1 + $n2 )) 10 -t $theta -r $theta $region -I 2 $n1 $n2 -n 2 $( echo "($N - $bneck_N)/$N" | bc -l ) -en $( echo  "$t_recover/(4*$N)" | bc -l ) 1 $( echo "$bneck_N/$N" | bc -l ) -ej $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 2 -eN $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 -seed $seed " 1>&2
#ms $(( $n1 + $n2 )) 10 -t $theta -r $theta $region -I 2 $n1 $n2 -n 2 $( echo "($N - $bneck_N)/$N" | bc -l ) -en $( echo  "$t_recover/(4*$N)" | bc -l ) 1 $( echo "$bneck_N/$N" | bc -l ) -ej $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 2 -eN $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 -seed $seed | msstats -I 2 $n1 $n2 -F

#exponential growth
echo "ms $(( $n1 + $n2 )) 10 -t $theta -r $theta $region -I 2 $n1 $n2 -n 2 $( echo "($N - $bneck_N)/$N" | bc -l ) -eg $( echo  "$t_recover/(4*$N)" | bc -l ) 1 $alpha -eg $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 0 -ej $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 2 -eN $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 -seed $seed" 1>&2 
ms $(( $n1 + $n2 )) 10 -t $theta -r $theta $region -I 2 $n1 $n2 -n 2 $( echo "($N - $bneck_N)/$N" | bc -l ) -eg $( echo  "$t_recover/(4*$N)" | bc -l ) 1 $alpha -eg $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 0 -ej $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 2 -eN $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 -seed $seed | msstats -I 2 $n1 $n2 -F

