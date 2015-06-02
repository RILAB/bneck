### bneck_selection_dist.cc
Old version of the code that only allows one kind of mutation, but draws it from an exponential distribution. Also allows printing neutral and selected sites split or combined.

### bneck_selection_ind.cc
new version of code. allows two kinds of mutations, but each has a fixed s. this should be modified to allow an exponential.
to compile, download fwdpp, replace the bneck_selection_ind.cc in the examples folder, and compile fwdpp normally (yeah, i am  lazy)

### ms_slide
runs sliding window analysis on  ms output.
to run: ms 10 1 -t 2 | ms_slide -L <length of region in bp> -w <size of window in bp> -s <step size to next window>
if s=w then windows are adjacent but nonoverlapping. s<w gives overlapping sliding windows.
to compile: g++ -I/usr/local/include -std=c++11 -lsequence ms_slide.cc -o ms_slide
