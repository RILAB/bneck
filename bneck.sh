#!/bin/bash -l
#SBATCH -D /home/jri/projects/bneck
#SBATCH -J bneck
#SBATCH -o outs/out-%j.txt
#SBATCH -p bigmem
#SBATCH -e errors/error-%j.txt
#SBATCH -c 8


N=100000 # wild Ne
t_recover=1000 # generations since recovery
mu=$(echo "3*10 ^ -8" | bc -l)
region=100000
theta=$( echo "4*$N*$mu*$region" | bc -l )
bneck_N=23200 #Ne during bneck
bneck_dur=5000 # generations
alpha=$( echo "-(1/(($bneck_dur)/(4*$N)))*l($bneck_N/$N)" | bc -l )

seed="$RANDOM $RANDOM $RANDOM"

echo "ms 10 1000 -t $theta -r $theta $region -eN $( echo  "$t_recover/(4*$N)" | bc -l ) $( echo "$bneck_N/$N" | bc -l ) -eN $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 -seed $seed | samplestats | cut -f 2 | /home/jri/src/msdir/stats" 
ms 10 1000 -t $theta -eN $( echo  "$t_recover/(4*$N)" | bc -l ) $( echo "$bneck_N/$N" | bc -l ) -eN $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 1 -seed $seed | msstats

#straight growth
#echo "ms 10 1000 -t $theta -eG $( echo  "$t_recover/(4*$N)" | bc -l ) $alpha -eG $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 0 -seed $seed | samplestats "
#ms 10 1000 -t $theta -eG $( echo  "$t_recover/(4*$N)" | bc -l ) $alpha -eG $( echo "($t_recover+$bneck_dur)/(4*$N)" | bc -l ) 0 -seed $seed | samplestats | cut -f 10 | /home/jri/src/msdir/stats
