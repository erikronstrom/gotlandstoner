#!/usr/bin/perl
use strict;
no integer;

use utf8;
use open IO => ':utf8';

use lib "include/";
use People;
initPeople('text/people/');

require 'include/parishes.pm';

my %TuneConf;
open(CONFIG, '<', 'config');
while(<CONFIG>) {
    next unless /^(\d+):\s*(.+)$/;
    my $Tune = $1;
    my $Conf = $2;
    my @Conf = split(/\s*,\s*/, $Conf);
    foreach my $C (@Conf) {
        $C =~ /(\w+)\s*=\s*(.+)/;
        $TuneConf{$Tune}->{$1} = $2;
    }
}
close(CONFIG);

open(OUTFILE, '>', 'book/tuneinfo.php');

print OUTFILE "<?php\n\n";
print OUTFILE '$tuneinfo = [' . "\n";

for my $num (214..727) {
    
    # if (my $section = $TuneConf{$num}->{"section"}) {
    #     $section = uc($section);
    #     $section =~ s/\{(\d+)MM\}/{$1mm}/g;
    #     $section =~ s/\\VSPACE/\\vspace/g;
    #     print OUTFILE "\\cleardoublepage\n";
    #     print OUTFILE "\\part*{\\textls[100]{$section}}\n";
    # }
    # if (my $textfile = $TuneConf{$num}->{"sectiontext"}) {
    #     my $text = htmlSubstitutions(&slurp("text/$textfile.tex"));
    #     #print OUTFILE "\\begin{center}\n";
    #     #print OUTFILE "\\parbox{16cm}{ \\setlength{\\parindent}{1.5em} $text}\n";
    #     # \\leftskip=1cm \\rightskip=1cm
    #     print OUTFILE "{\\setlength{\\parindent}{1.5em} $text \n}\n\n";
    #     #print OUTFILE "\\end{center}\n\n";
    # }

    my $abc = &slurp("abc/song-$num.abc");
    &processTune($abc, $num);
}

print OUTFILE "];\n\n";
print STDERR "\n";

close(OUTFILE);

sub processTune() {
    my $Tune  = shift;
    my $Num   = shift;

    # print STDERR "$Num ";
    
    $Tune =~ s/\%.*$//mg;
    $Tune =~ s/\s+$//mg;
    $Tune =~ s/\\\n//sg;

    my @Lines = split("\n", $Tune);
    
    # Process headers and save them as well
    my %Headers;
    $Headers{'X'} = $Num;

    my $Title;
    my $Source = '';
    my $PostText;
    my $Music;
    my @Lyrics;
    foreach my $Line (@Lines) {
        $Line =~ s/\%.*$//mg;     # Remove comments
        
        if (defined $Music) {
            $Music .= "$Line\n";
            next;
        }

        my $OriginalLine = $Line;
        $Line =~ s/\^/\\\^\{\}/g;    # Replace circumflex
        # $Line =~ s/\»/''/g;          # Replace quote marks (guillemotright)
        
        if ($Line =~ /^([ML]):(\S*)/) {
            $Headers{$1} = $2;
        }
        if ($Line =~ /^T:(.*)/ && !$TuneConf{$Num}->{"hidetitle"}) {
            $Title = $1;
            $Title =~ s/[\.\,\;]$//; # Remove trailing punctuation
        }
        if ($Line =~ /^[SNH]:(.*)/) {
            
            #next if $Line =~ /^Q:/;

            my $Text = $1;
            if ($Text =~ /Stämning:\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
                next;
            }
            
            $Source .= $Text;
            #if ($Source =~ /\.\s*$/) {
            #   $Source .= "\\\\\n";
            #} else {
                $Source .= " ";
            #}
        }
        if ($Line =~ /^K:(\S*)/) {
            $Headers{'K'} = $1;
            $Music = '';
        }
        if ($Line =~ /^W:(.*)/) {
            push(@Lyrics, $1);
        }
    }
    #$Source =~ s/\\\\\[0\.1cm\]$//;
    
    unless (defined $Headers{'M'}) {
        print STDERR "Tune $Num has no meter, skipped.\n";
        return undef;
    }
    unless (defined $Headers{'K'}) {
        print STDERR "Tune $Num has no key, skipped.\n";
        return undef;
    }
    
    print OUTFILE "\n";

    # Title and text

    $PostText = &slurp("text/text-$Num.tex") if (-e "text/text-$Num.tex");
    if (-e "text/song-$Num.tex") {
        $Source = &slurp("text/song-$Num.tex");
    }
    my $MultipleLines = (length($Source) > 90) || ($Source =~ /\n/);
    my $TextBox = $TuneConf{$Num}->{"textbox"};
    if (defined $TextBox) {
        if ($TextBox) {
            $MultipleLines = 1;
        } else {
            $MultipleLines = 0;
        }
    } else {
        $TextBox = "12cm";
    }

    $Source = &insertPersonLinks($Source, $Num);
    $Source = &insertParishLinks($Source, $Num);

    my @Keys = ("'" . $Headers{'K'} . "'");
    my $Parts = &countParts($Music, $Num);

    print OUTFILE "  $Num => [\n";
    print OUTFILE "    'title'       => '${\htmlSubstitutions($Title)}',\n";
    print OUTFILE "    'text'        => '$PostText',\n" if $PostText;
    print OUTFILE "    'source'      => '${\htmlSubstitutions($Source)}',\n";
    print OUTFILE "    'sourceWidth' => '$TextBox',\n";
    print OUTFILE "    'parts'       => $Parts,\n";
    print OUTFILE "    'key'         => [" . join(', ', @Keys) . "],\n";
    print OUTFILE "    'meter'       => '" . $Headers{'M'} . "'\n";
    print OUTFILE "  ]";
    print OUTFILE "," unless $Num == 727;
    print OUTFILE "\n";
    
#    print OUTFILE "\\vspace{0.5cm}\n\n" unless $BreakAfter;
}

sub slurp() {
    my $filename = shift;
    local $/;
    open(my $fh, "<", $filename) or die("Can't open $filename for slurping");
    my $data = <$fh>;
    close($fh);
    return $data;
}

sub countParts() {
    my $Music = shift;
    my $Num   = shift;
    $Music = join("", grep { $_ !~ /^[wW]:/ } split(/\n/, $Music));
    my @Parts = split(/[\|\:]{2}/, $Music);
    my $PartCount = 0;
    print STRERR "Count parts for $Num\n";
    foreach my $Part (@Parts) {
        my $Barlines = grep(/\|/, split("", $Part));
        # print STDERR "  part: $Part  >>>> $Barlines\n";
        $PartCount++ if $Barlines > 1;
    }
    return $PartCount;
}

sub htmlSubstitutions() {
    my $Text = shift;


    $Text =~ s/\'/\\'/g; # not for html but for php

    $Text =~ s/\\textit\{(.*?)\}/<i>$1<\/i>/g;
    $Text =~ s/\\@//g;

    # $Text =~ s/(Uppt|Omkr|Meddel|Skoll|Kapt|Joh|Nikl|And|övers|sv|enl)\. /\1.\\\@ /ig;
    # $Text =~ s/m\. m\./m.\\\,m./g; # TODO: lookahead for next sentence
    # $Text =~ s/t\. f\./t.\\\,f./g; # TODO: lookahead for next sentence
    # $Text =~ s/m\. fl\. (?=[a-z])/m.\\\,fl.\\@ /g;
    # $Text =~ s/m\. fl\./m.\\\,fl./g;
    # $Text =~ s/f\. d\./f.\\\,d.\\\@/g; # TODO: lookahead for next sentence
    # $Text =~ s/o\. s\. v\./o.\\\,s.\\\,v.\\\@/g; # TODO: lookahead for next sentence
    # $Text =~ s/ fr\. / fr.\\\@ /g;
    # $Text =~ s/ Ol\. / Ol.\\\@ /g;
    # $Text =~ s/ Joh\. / Joh.\\\@ /g;
    # $Text =~ s/d\. ([yä])\./d.\\\,\1./g; # TODO: lookahead for next sentence
    # $Text =~ s/ f\. / f.\\\@ /g; # TODO: lookahead for next sentence
    $Text =~ s/([\s\n])\-\-([\s\n])?/$1&mdash;$2/g;
    $Text =~ s/(\d)\-(\d)/$1&ndash;$2/g;
    $Text =~ s/–/&ndash;/g;
    $Text =~ s/—/&mdash;/g;
    $Text =~ s/---/&mdash;/g;
    $Text =~ s/--/&ndash;/g;
    $Text =~ s/\\textesh{}/ʃ/g;
    # $Text =~ s/ɷ/\\textcloseomega{}/g;
    # $Text =~ s/»/\\guillemotright{}/g;
    # $Text =~ s/’/\'/g;

    # $Text =~ s/¼/\\sfrac{1}{4}/g;

    return $Text;
}

sub insertPersonLinks() {
    my $Text = shift;
    my $Num  = shift;

    my $Table = getReversePeople($Num);
    # if ($Num == 218) {
    #     print STDERR "Keys:\n";
    #     foreach my $Name (sort keys %$Local) {
    #         print STDERR "$Name: $Local->{$Name}\n";
    #     }
    # }

    foreach my $Name (keys %$Table) {
        $Text =~ s/$Name/<a href="web\/personer\/$Table->{$Name}" class="person">$Name<\/a>/g;
    }

    return $Text;
}

sub insertParishLinks() {
    my $Text = shift;
    my $Num  = shift; # currently ignored
    foreach my $Parish (@Parishes::Parishes) {
        $Text =~ s/(?<!\>)\Q$Parish\E(?=[\s\.\,\?\!])/<a href="web\/socknar\/$Parish" class="socken">$Parish<\/a>/g;
    }
    return $Text;
}
