#!/usr/bin/perl
use strict;

use utf8;
use open IO => ':utf8';

my $SourceDir = 'text/web/';
my $TargetDir = 'text/people/';

die("Won't overwrite!\n"); # This script was a use-once!


opendir(my $dh, $SourceDir) || die;
while(my $FileName = readdir $dh) {
    next unless $FileName =~ /^(.*)\.html$/;
    my $Name = $1;
    my $Text = &slurp($SourceDir . $FileName);
    open(OUTFILE, '>', $TargetDir . $Name . '.tex');
    &processPerson($Text);
    close(OUTFILE);
}
closedir $dh;


sub slurp() {
    my $filename = shift;
    local $/;
    open(my $fh, "<", $filename) or die("Can't open $filename for slurping");
    my $data = <$fh>;
    close($fh);
    return $data;
}

sub processPerson() {
    my $Text = shift;

    $Text =~ s/<strong>(.*?)<\/strong>/\\textbf{$1}/g;
    $Text =~ s/<a href="([\w\-]+)\.html">(.*?)<\/a>/\\href{$1}{$2}/g;
    $Text =~ s/<span class="socken">(.*?)<\/span>/$1/g;
    $Text =~ s/<p>//g;
    $Text =~ s/<\/p>/\n\n/g;
    #$Text =~ s/^\s*(\d+|<a href="web\/\d+).*//mg;
    $Text =~ s/<a href="web\/\d+[^>]+>(\d+)<\/a>/$1/g;
    $Text =~ s/^\s+$//mg;     # Remove contents of whitespace-only lines
    $Text =~ s/\n\n+/\n\n/g;  # Collapse > 2 newlines
    $Text =~ s/\n\n$/\n/;     # Remove trailing newlines except for the last
    $Text =~ s/^\n+//;        # Remove leading newlines
    $Text =~ s/^\s+(?=\d)//mg;
    $Text =~ s/^(\d+,\s*)+\n/$1 /mg;
    $Text =~ s/^(?=\d+)/\n/mg;

    print OUTFILE $Text;
}

