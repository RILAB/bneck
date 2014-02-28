# Bneck sims

Do some bneck sims to show similarity and differences of bneck models.

See [r code](http://rpubs.com/rossibarra/bneck) for descriptions of models.

# SLIM sims

Doing some sims with [SLIM](http://www.stanford.edu/~messer/software) to try look at deleterious variants and D.

# Sims with fwdpp as well, in fwdpp.sh

## Round 1
results files for first round of fwdpp sims in results, see [bneck_ftw R code analysis](http://rpubs.com/rossibarra/bneck_ftw) for analysis details.


# Files

split.pl takes ms output from fwdpp (which alternates netural/selected) and splits into two files. should automate rest of job to get msstats output

combine.pl takes ms output which alternates netural/selected and combines into one read block. No longer necessary as fwdpp code can write a combined ms block instead.

cleanup.sh takes ms output runs split.pl, msstats, writes to neutral and selected files for separate runs

bneck_selection_dist.cc is a modified version of the bneck_selection.cc code from Kevin Thornton's [fwdpp](https://github.com/molpopgen/fwdpp). Instead of inputting a constant s on the command line, you enter the mean for an exponential and a percent of selected mutations which are positive.  All selected mutations (positive and negative) are drawn from the same exponential.

