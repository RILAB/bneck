* combine.pl is old, ignore.  
* bneck.sh runs ms sims of different bottleneck scernarios  
* cleanup.sh cleans up the thousands of output runs from forward sims into a single file for neutral and selected sites  
* fwdpp.sh runs fwdpp. note that model is hard coded into the script, you have to change Ne in the script to switch between maize and teosinte. it is run as 'sbatch -p <queue> fwdpp.sh <s>' where s is the selection coeffiient. note that the code only makes a log file if you are running 1977 or more simulations.  
* split.pl splits apart combined fwdpp ms out put and formats it for libsequence to read

