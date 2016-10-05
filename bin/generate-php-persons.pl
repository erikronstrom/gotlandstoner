#!/usr/bin/perl
use strict;

use utf8;
use open IO => ':utf8';

use lib "include/";
use People;

my $SourceDir = 'text/people/';


initPeople($SourceDir);


open(OUTFILE, '>', 'book/personinfo.php');

print OUTFILE "<?php\n\n";
print OUTFILE '$personinfo = [' . "\n";

foreach my $FileName (sort keys %People) {
    my $Person = $People{$FileName};
    my $Name = $Person->{"name"};
    my $Tunes = $Person->{"tunes"};
    print OUTFILE "  '$FileName' => [\n";
    print OUTFILE "    'filename' => '$FileName',\n";
    print OUTFILE "    'name'     => '$Name',\n";
    print OUTFILE "    'tunes'    => [" . join(', ', @$Tunes) . "]\n";
    print OUTFILE "  ],\n";
}


print OUTFILE "];\n\n";
print OUTFILE '$reversed_people = [' . "\n";
foreach my $Name (sort keys %ReversePeople) {
    my $FileName = $ReversePeople{$Name};
    print OUTFILE "  '$Name' => '$FileName',\n";
}
print OUTFILE "];\n\n";
close OUTFILE;


