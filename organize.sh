n=$1
cat results/header.txt <( grep -v "pop" outs/out-$n.* | cut -d ":" -f 2- ) > results/"$n"stats.txt; cp errors/error-"$n".34.txt results/"$n"_stderr.txt
