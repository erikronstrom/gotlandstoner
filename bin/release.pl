#!/usr/bin/perl

use warnings;
use strict;

use Time::Piece;

my $inPattern = "abc/song-%d.abc";
my $outDirPattern = "release/gotlandstoner-%s";
my $outFileName = "fredin.abc";

my $version = $ARGV[0];
die("Usage: release.pl version\n") unless $version;
die("Bad version number: $version (valid numbers are e.g. 0.1 or 1.4.3)\n") unless ($version =~ /^\d+\.\d+(\.\d+)?$/);


my $outdir = sprintf($outDirPattern, $version);
my $outfile = "$outdir/$outFileName";

if (-d $outdir) {
    die "Release $version already exists!\n";
} else {
    mkdir $outdir;
}

open(OUTFILE, '>', $outfile) or die("Could not open $outfile for writing");

my $date = localtime->strftime('%Y-%m-%d');
print OUTFILE "%abc-2.1\n";
print OUTFILE "I:abc-charset iso-8859-1\n";
print OUTFILE "\nGotlandstoner $version ($date)\n";

print OUTFILE "\n";

for my $i (214..727) {
        open(my $in, "<", sprintf($inPattern, $i));
        while (my $line = <$in>) {
            print OUTFILE $line unless $line =~ /^Z\:/;
        }
        close($in);
        
}

close(OUTFILE);
