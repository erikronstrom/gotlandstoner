#!/usr/bin/perl

use warnings;
use strict;

use POSIX;

my $maxY = 0;
my $mmheight;
my $viewBoxHeight;
my $svghead;
my $svgbody = '';
while(my $line = <>) {
    $line =~ s//»/g; # Workaround for missing glyph encoding in pre-made Computer Modern web font
    if ($line =~ /\<svg.*height\=\"([\d\.]+)mm\".*viewBox\=\"[\d\.]+\s+[\d\.]+\s+[\d\.]+\s+([\d\.]+)\s*\"/) {
        $mmheight = $1;
        $viewBoxHeight = $2;
        $svghead = $line;
        # print "viewBoxHeight before: $viewBoxHeight\n";
    } else {
        $svgbody .= $line;
    }
    if ($line =~ /\<line transform\=\"translate\([\d\.]+\,\s*([\d\.]+)\)/) {
        $maxY = $1 if $1 > $maxY;
        # print "$1 new maxY: $maxY\n";
    }
    if ($line =~ /\<line [^\>]*y1\=\"([\d\.]+)\"/) {
        $maxY = $1 if $1 > $maxY;
        # print "$1 new maxY: $maxY\n";
    }
}

my $ratio = $mmheight / $viewBoxHeight;
my $newheight = $maxY + 10;
my $newmmheight = ceil($ratio * $newheight);
# print "$i: $maxY  $mmheight $viewBoxHeight  " . (($maxY + 10) * $ratio) . "mm\n";

$svghead =~ s/height\=\"[\d\.]+mm\"/height="${newmmheight}mm"/;
$svghead =~ s/viewBox\=\"([\d\.]+\s+[\d\.]+\s+[\d\.]+\s+)[\d\.]+\s*\"/viewBox="$1$newheight"/;

print $svghead;
print $svgbody;
