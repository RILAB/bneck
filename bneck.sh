#!/bin/bash -l
#SBATCH -D /home/jri/projects/bneck
#SBATCH -J bneck
#SBATCH -o outs/out-%j.txt
#SBATCH -p bigmem
#SBATCH -e errors/error-%j.txt

module load libsequence

N=100000 # wild Ne
t_recover=1000 # generations since recovery
mu=$(echo "3*10 ^ -8" | bc -l) # mutation rate
region=100000 # length of region
theta=$( echo "4*$N*$mu*$region" | bc -l ) # assume rho = theta
bneck_N=23200 # Ne during bneck
bneck_dur=5000 # generations
alpha=$( echo "-(1/(($bneck_dur)/(4*$N)))*l($bneck_N/$N)" | bc -l ) # growth rate

seed="$RANDOM $RANDOM $RANDOM"

echo "ms 20 1000 -t $theta -r $theta $region -I 2 10 10 -n 2 $( echo "$N - $bneck_N" | bc -l ) -en $( echo  "$t_recover/(4*$N)" | bc -l ) 1 $( echo "$bneck_N/$N" | bc -l ) -ej $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 2 -eN $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 -seed $seed " 1>&2
ms 20 1000 -t $theta -r $theta $region -I 2 10 10 -n 2 $( echo "$N - $bneck_N" | bc -l ) -en $( echo  "$t_recover/(4*$N)" | bc -l ) 1 $( echo "$bneck_N/$N" | bc -l ) -ej $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 2 -eN $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 -seed $seed | msstats 

#straight growth
#echo "ms 10 1000 -t $theta -eG $( echo  "$t_recover/(4*$N)" | bc -l ) $alpha -eG $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 0 -seed $seed | samplestats "
#ms 10 1000 -t $theta -eG $( echo  "$t_recover/(4*$N)" | bc -l ) $alpha -eG $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 0 -seed $seed | samplestats | cut -f 10 | /home/jri/src/msdir/stats
