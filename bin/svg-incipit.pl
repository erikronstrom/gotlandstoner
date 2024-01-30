#!/usr/bin/perl

use warnings;
use strict;

my $LineElements = 0;
my $OffsetX;
my $OffsetY;

my $Head;
my $Output = '';

my $Scale = 0.4;


while (my $Line = <>) {
    if ($Line =~ /<svg /) {
        $Head = $Line;
        next;
    }
    if (($Line =~ /<line .*x1="([\-\d\.]+)".*x2="([\-\d\.]+)"/) and ($2 > ($1 + 50))) {
        $LineElements++;
        if ($LineElements == 5) {
            if ($Line =~ /translate\(([0-9\.]+), ([0-9\.]+)\)/) {
                $OffsetX = $1;
                $OffsetY = $2;
            } elsif ($Line =~ /x1="([\-\d\.]+)".*y1="([\-\d\.]+)"/) {
                $OffsetX = $1;
                $OffsetY = $2;
            } else {
                print STDERR "Could not find offsets!\n";
            }
        }
        last if $LineElements > 5;
    }
    $Output .= $Line;
}

$OffsetY -= 4;

$OffsetX = -$OffsetX;
$OffsetY = -$OffsetY;

#$OffsetX *= $Scale;
#$OffsetY *= $Scale;

# print STDERR "Offset: $OffsetX $OffsetY\n";

$Head =~ s/width="(.*?)"/width="50mm"/;
$Head =~ s/height="(.*?)"/height="10mm"/;
$Head =~ s/viewBox="(.*?)"/viewBox="0 0 65 12.5"/;

print $Head;
print "<g transform=\"translate($OffsetX, $OffsetY)\">\n\n";
print $Output;
print "</g></svg>\n";
