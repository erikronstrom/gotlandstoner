#!/usr/bin/perl

use warnings;
use strict;

use POSIX;

my $pattern = "svg/%d.svg";

my $From = $ARGV[0] || 214;
my $To   = $ARGV[1] || 727;

for my $i ($From..$To) {
    # open(my $in, "<", sprintf($inPattern, $i));
    # system("abc2ly", "-o" sprintf($outPattern, $i), sprintf($inPattern, $i));
    my $filename = sprintf($pattern, $i);
    next unless -e $filename;
    
    open(my $in, "<", $filename);
    my $maxY = 0;
    my $mmheight;
    my $viewBoxHeight;
    my $svghead;
    my $svgbody = '';
    while(my $line = <$in>) {
        $line =~ s//»/g; # Workaround for missing glyph encoding in pre-made Computer Modern web font
        if ($line =~ /\<svg.*height\=\"([\d\.]+)mm\".*viewBox\=\"[\d\.]+\s+[\d\.]+\s+[\d\.]+\s+([\d\.]+)\s*\"/) {
            $mmheight = $1;
            $viewBoxHeight = $2;
            $svghead = $line;
        } else {
            $svgbody .= $line;
        }
        if ($line =~ /\<line transform\=\"translate\([\d\.]+\,\s*([\d\.]+)\)/) {
            $maxY = $1 if $1 > $maxY;
        }
    }
    close($in);

    my $ratio = $mmheight / $viewBoxHeight;
    my $newheight = $maxY + 10;
    my $newmmheight = ceil($ratio * $newheight);
    #print "$i: $maxY  $mmheight $viewBoxHeight  " . (($maxY + 10) * $ratio) . "mm\n";

    $svghead =~ s/height\=\"[\d\.]+mm\"/height="${newmmheight}mm"/;
    $svghead =~ s/viewBox\=\"([\d\.]+\s+[\d\.]+\s+[\d\.]+\s+)[\d\.]+\s*\"/viewBox="$1$newheight"/;

    open(my $out, ">", $filename);
    print $out $svghead;
    print $out $svgbody;
    close($out);
}
