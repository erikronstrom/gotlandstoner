#!/usr/bin/perl
use strict;
no integer;

my $From = $ARGV[0] || 320;
my $To   = $ARGV[1] || 360;

##############################################################

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


open(OUTFILE, '>', 'book/fredin.lytex');
print OUTFILE '\documentclass[a4paper]{report}' . "\n";
print OUTFILE '\usepackage[latin1]{inputenc}' . "\n";
#print OUTFILE '\usepackage{cmap}' . "\n";       # Make pdf searchable
#print OUTFILE '\usepackage{times}' . "\n";      # Use times font
print OUTFILE '\usepackage[T1]{fontenc}' . "\n"; # For T1 encoding
print OUTFILE "\\usepackage[top=19mm,left=15mm,right=15mm,bottom=13mm,includefoot,twoside,bindingoffset=7mm]{geometry}\n";
print OUTFILE '\setcounter{secnumdepth}{0}' . "\n"; 

print OUTFILE '\usepackage{fancyhdr}' . "\n";
print OUTFILE '\fancypagestyle{plain}{ \fancyhf{} ' . "\n";
# print OUTFILE '\fancyfoot[LE,RO] {\thepage} ' . "\n";
print OUTFILE '\fancyfoot[C] { \scriptsize GOTLANDSTONER } ' . "\n";
print OUTFILE '\renewcommand{\headrulewidth}{0pt}' . "\n";
print OUTFILE '\renewcommand{\footrulewidth}{0pt}}' . "\n";
print OUTFILE '\pagestyle{plain}' . "\n";

print OUTFILE '\begin{document}' . "\n";
print OUTFILE '\title{Gotlandstoner}' . "\n";
print OUTFILE '\author{August Fredin}' . "\n";
print OUTFILE '\setlength{\parindent}{0pt}' . "\n";
#print OUTFILE '\setlength{\parskip}{1ex}' . "\n";

print OUTFILE '\newcommand{\tunename}[1]{' . "\n";
print OUTFILE '\refstepcounter{section}' . "\n";
print OUTFILE '\addcontentsline{toc}{section}{\protect\numberline{\thesection}#1}' . "\n";
print OUTFILE '\begin{center}' . "\n";
print OUTFILE '\LARGE \textbf{#1}' . "\n\n";
print OUTFILE '\vspace*{12pt}' . "\n";
print OUTFILE '\end{center}' . "\n";
print OUTFILE '}' . "\n";

print OUTFILE '\part*{Polskor}' . "\n";

# print OUTFILE "\\cleardoublepage\n";

for my $num ($From..$To) {
    my $abc = &slurp("abc/song-$num.abc");
    my $notes = &slurp("ly/notes-$num.ly");
    
    &processTune($abc, $num, $notes);
}

print STDERR "\n";

print OUTFILE '\end{document}' . "\n";

close(OUTFILE);


sub processTune() {
    my $Tune  = shift;
    my $Num   = shift;
    my $Notes = shift;

    print STDERR "$Num ";
    
    $Tune =~ s/\%.*$//mg;
    $Tune =~ s/\s+$//mg;
    $Tune =~ s/\\\n//sg;

    my @Lines = split("\n", $Tune);
    
    # Process headers and save them as well
    my %Headers;
    $Headers{'X'} = $Num;

    my $Title;
    my $Source = '';
    my $Music;
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
        if ($Line =~ /^T:(.*)/) {
            $Title = $1;
        }
        if ($Line =~ /^[SNH]:(.*)/) {
            
            my $Text = $1;
            if ($OriginalLine =~ /Stämning:\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
                next;
            }
            
            $Text =~ s/(Uppt|Omkr)\. /\1.\\\@ /ig;
            $Text =~ s/m\. fl\./m.\\\@ fl./g; # TODO: lookahead for next sentence
            $Text =~ s/d\. ([yä])\./d.\\\@ \1./g; # TODO: lookahead for next sentence
            $Text =~ s/ f\. / f.\\\@ /g; # TODO: lookahead for next sentence
            
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
    
    my $SpaceBefore = $TuneConf{$Num}->{"spacebefore"} || "5mm";
    my $SpaceAfter  = $TuneConf{$Num}->{"spaceafter"} || "1cm";
    my $BreakBefore = $TuneConf{$Num}->{"newpage"} || 0;
    my $BreakAfter  = $TuneConf{$Num+1}->{"newpage"};

    print OUTFILE "\n\n";

    print OUTFILE "\\newpage\n" if $BreakBefore;

    # Title and text
    print OUTFILE "\\tunename{$Title}\n" if $Title;
    #print OUTFILE "\\hspace{14mm}\\parbox{16cm}{ $Source \\\\* }\n\n";
    my $MultipleLines = (length($Source) > 75) || ($Source =~ /\n/);
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
    
    if ($MultipleLines) {
        print OUTFILE "\\begin{flushright} \\parbox{$TextBox}{$Source} " .
            "\\end{flushright}\n\n";
    } else {
        print OUTFILE "\\begin{flushright} $Source \\end{flushright}\n\n";
    }

    # Extra vertical space before score
    my $SpaceBefore = $TuneConf{$Num}->{"spacebefore"} || "0mm";
    print OUTFILE "\\vspace{$SpaceBefore}\n";

    print OUTFILE "\\begin{lilypond}\n";
    
    
    #########
        
    print OUTFILE '\include "../include/repeat-bracket.ly"' . "\n";
    
    print OUTFILE '\layout {' . "         % $Headers{'X'}\n";
    print OUTFILE '    indent = 1.4\cm'. "\n";

    print OUTFILE '}' . "\n";
    print OUTFILE "#(set-global-staff-size 20)\n";
    
    # print OUTFILE "\\layout {\n";
    # print OUTFILE "  \\context {\n";
    # print OUTFILE "    \\Staff\n";
    # print OUTFILE "    \\override VerticalAxisGroup.default-staff-staff-spacing =\n";
    # print OUTFILE "      #'((basic-distance . 20)\n";
    # print OUTFILE "         (minimum-distance . 19)\n";
    # print OUTFILE "         (padding . 1))\n";
    # print OUTFILE "} }\n";
    
    
    print OUTFILE '\score { {' . "\n";

    print OUTFILE "\\set Staff.instrumentName = " .
        "\\markup { \\huge \\bold \"$Headers{'X'}.\" \\hspace #1.2 } \n";
    print OUTFILE "\\set Staff.shortInstrumentName = \"\"\n";

    my $SSpacing = $TuneConf{$Headers{'X'}}->{"systemspacing"} || 0;
    $SSpacing = -7.5 - ($SSpacing * 0.5);

    print OUTFILE "\\override Staff.VerticalAxisGroup #'minimum-Y-extent = #'($SSpacing . 6)";
    

    print OUTFILE "\\override Score.PaperColumn #'keep-inside-line = ##t\n";

    #print OUTFILE "\\override Staff.StaffSymbol #'thickness = #0.9\n";
    print OUTFILE '        \override Score.BarNumber #' . "'stencil = " . '##f' . "\n";
    #print OUTFILE "        \\set Timing.beamExceptions = #'()\n";
    print OUTFILE "        \\set Timing.beamHalfMeasure = ##f\n";
    
    print OUTFILE $Notes;
    
    my $NS = $TuneConf{$Headers{'X'}}->{"notespacing"} || 0;
    $NS = 6 - $NS;

    print OUTFILE "}\n";
    print OUTFILE "    \\layout {\n";
    print OUTFILE "    \\context {\n";
    print OUTFILE "      \\Score\n";
    print OUTFILE "      \\override SpacingSpanner ";
    print OUTFILE "#'common-shortest-duration = #(ly:make-moment $NS 64)\n";
    print OUTFILE "} } \n";

    print OUTFILE "}\n\n";
    
    
    ###########
    
    print OUTFILE "\\end{lilypond}";
    
    if (!$SpaceAfter || $SpaceAfter eq "0cm" || $BreakAfter) {
        $SpaceAfter = "";
    } else {
        $SpaceAfter = "\n\n\\vspace{$SpaceAfter}\n\n";
    }
    
    my $line = $TuneConf{$Headers{'X'}}->{"line"};
    unless (defined $line && $line == 0) {
        my $lineoffset = $TuneConf{$Headers{'X'}}->{"lineoffset"} || 0;
        $lineoffset -= 5;
        $lineoffset -= 5 unless $BreakBefore && $BreakAfter;
        print OUTFILE '\begin{center}' . "\n";
        print OUTFILE '\kern' . $lineoffset . 'pt' if $lineoffset; # e.g. 5pt
        print OUTFILE '\line(1,0){200}' . "\n";
        print OUTFILE '\end{center}' . "\n";
    }
    
    print OUTFILE $SpaceAfter;

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

