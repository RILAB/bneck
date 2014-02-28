#/usr/bin/perl
use strict;
use warnings;

my $file = $ARGV[0];
open FILE, "<$file" or die "no file to open\n\n";

my @data = <FILE>;

#segsites
my @segs1 = split(/\:/,$data[1]);
my @segs2 = split(/\:/,$data[24]);

if($segs2[1]==0){

	for my $i (0..22){
		print $data[$i];
	}
	close FILE;
	exit(0);
}

print $data[0];
print "segsites: ", $segs1[1] + $segs2[1],"\n";

#positions
my @pos1=split(/\s/,$data[2]);
my @pos2=split(/\s/,$data[25]);
shift(@pos1);
shift(@pos2);
my @pos3=(@pos1,@pos2);
@pos3 = sort {$a<=>$b} @pos3;
print "positions: ",@pos3;

for my $i (3..22){
	chomp $data[$i];
	print $data[$i],$data[$i+23];
}
close FILE;
exit(0);
