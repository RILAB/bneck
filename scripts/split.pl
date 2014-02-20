#!/usr/bin/perl
use strict;
use warnings;

open FILE, "<$ARGV[0]";
my @temp=split(/\./,$ARGV[0]);
my $run=$temp[1];
open N, ">>neutral.$run.txt"; 
open S, ">>selected.$run.txt"; 

my $neutral=0; 

while(<>){ 
	if($_=~m/\/\// && !$neutral ){ 
		$neutral=1;
		print N $_; 
	} 
	elsif($_=~m/\/\// && $neutral ){ 
		$neutral=0;
		print S $_ 
	}
	elsif($_!~/\/\//){
	print S $_ if !$neutral;
	print N $_ if $neutral;
	}
}
close S;
close N;
close FILE;
