#!/usr/bin/perl

use warnings;
use strict;

my $pattern = "abc/song-%d.abc";

my $outfile;

while(<>) {
	if (/^X\:(\d+)/) {
		close $outfile if $outfile;
		my $filename = sprintf($pattern, $1);
		open($outfile, ">", $filename) or die("Can't open $filename for writing");
		select($outfile);
		print;
	} else {
		die unless $outfile;
		print;
	}
}

close $outfile;
