#!/usr/bin/perl
use strict;

use utf8;
use open IO => ':utf8';

require "include/parishes.pm";
require "include/hyphenation.pm";

my $SourceDir = 'text/people/';
my $TargetDir = 'text/people/html/';


opendir(my $dh, $SourceDir) || die;
while(my $FileName = readdir $dh) {
    next unless $FileName =~ /^(.*)\.tex$/;
    my $Name = $1;
    my $Text = &slurp($SourceDir . $FileName);
    open(OUTFILE, '>', $TargetDir . $Name . '.html');
    # print STDERR "$FileName\n";
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

    # Remove numbers in the end
    $Text =~ s/^[\d\s\,]+$//mg;

    # Bold and italic
    $Text =~ s/\\textbf{(.*?)}/<strong>$1<\/strong>/g;
    $Text =~ s/\\textit{(.*?)}/<i>$1<\/i>/g;

    # Links
    $Text =~ s/\\href\{(\d+?)\}{(.*?)\}/<a href="web\/$1" class="tune">$2<\/a>/g;
    $Text =~ s/\\href\{(.*?)\}{(.*?)\}/<a href="web\/personer\/$1" class="person">$2<\/a>/g;

    # Paragraphs
    $Text =~ s/\n\n/<\/p>\n<p>/g;
    $Text = "<p>$Text</p>";

    # Abbreviations
    $Text =~ s/([a-zåäö]+\.\\,([a-zåäö]+\.\\,)*[a-zåäö]+)\\\@\./<abbr>$1.<\/abbr><span class="sentencespace"> <\/span>/g;
    $Text =~ s/(?<!\\,)(?<!<abbr>)([a-zåäö]+\.\\,([a-zåäö]+\.\\,)*[a-zåäö]+\.)/<abbr>$1<\/abbr>/g;
    #$Text =~ s/\\,/<span class="thinspace">&nbsp;<\/span>/g;
    $Text =~ s/\\,/&nbsp;/g;

    # TeX characters
    $Text =~ s/'/’/g;
    $Text =~ s/---/&mdash;/g;
    $Text =~ s/--/&ndash;/g;

    # Remove whitespace before </p>
    $Text =~ s/\s+<\/p>/<\/p>/g;

    # Sentence spacing (see also special case above)
    $Text =~ s/(?<=[a-zåäö»][\.\?\!]) /<span class="sentencespace"> <\/span>/g;
    $Text =~ s/\.\\\@ /. /g;
    $Text =~ s/\\\@//g; # get rid of remaining \@ sequences

    # Parishes
    foreach my $Parish (@Parishes::Parishes) {
        $Text =~ s/(?<!\>)\Q$Parish\E(?=[\s\.\,\;\?\!])/<a href="web\/socknar\/$Parish" class="socken">$Parish<\/a>/g;
    }

    # Hypenation
    foreach my $Word (keys %Hyphenation::Words) {
        $Text =~ s/\Q$Word\E/&shy($Word)/eg;
    }

    print OUTFILE $Text;
}

sub shy() {
    my $Word = shift;
    my $Subst = $Hyphenation::Words{$Word};
    $Subst =~ s/\-/&shy;/g;
    return $Subst;
}