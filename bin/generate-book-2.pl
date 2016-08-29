#!/usr/bin/perl
use strict;
no integer;

use utf8;

#use Getopt::Long;
use Digest::MD5;

my $From = $ARGV[0] || 320;
my $To   = $ARGV[1] || 360;

#my $From   = 214;
#my $To     = 727;
#my $Simple = 0;

#GetOptions("from=i" => \$From,
#           "to=i"   => \$To,
#           "simple" => \$Simple)
#  or die("Error in command line arguments\n");

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

# for my $num (214..420) {
#     print "$num " unless $TuneConf{$num}->{'newpage'} == 1;
# }
# print "\n";
# exit();


open(OUTFILE, '>', 'book/fredin.latex');

my $template = &slurp("include/book-template.latex");

my %params;


my $book = $template;
$book =~ s/%\(\(([\w\-]+)\)\)%/$params{$1}/ge;

print OUTFILE $book;


for my $num ($From..$To) {
    
    if (my $section = $TuneConf{$num}->{"section"}) {
        $section = uc($section);
        $section =~ s/\{(\d+)MM\}/{$1mm}/g;
        $section =~ s/\\VSPACE/\\vspace/g;
        print OUTFILE "\\cleardoublepage\n";
        print OUTFILE "\\part*{\\textls[100]{$section}}\n";
    }
    if (my $textfile = $TuneConf{$num}->{"sectiontext"}) {
        my $text = &slurp("text/$textfile.tex");
        #print OUTFILE "\\begin{center}\n";
        #print OUTFILE "\\parbox{16cm}{ \\setlength{\\parindent}{1.5em} $text}\n";
        # \\leftskip=1cm \\rightskip=1cm
        print OUTFILE "{\\setlength{\\parindent}{1.5em} $text \n}\n\n";
        #print OUTFILE "\\end{center}\n\n";
    }

    my $abc = &slurp("abc/song-$num.abc");
    #my $song = &slurp("book/song-$num.ly");
    my $songfile = "book/song-$num";
    open(my $lyfile, '<', "$songfile.ly");
    binmode($lyfile);
    my $md5 = Digest::MD5->new->addfile($lyfile)->hexdigest();
    close($lyfile);
    #my $md5 = `md5 -q $songfile.ly`;
    #$md5 =~ s/\s//g;
    unless (-e "$songfile-$md5-crop.pdf") {
        system("lilypond", "-l", "WARNING", "-o", "$songfile-$md5", "$songfile.ly") unless -e "$songfile-$md5.pdf";
        `pdfcrop $songfile-$md5.pdf`; # Use backticks instead of system() to suppress output
        unlink("$songfile-$md5.pdf");
    }
    my $pages = $TuneConf{$num}->{"pages"} || 1;
    my $song = "";
    for my $page (1..$pages) {
        if ($page > 1) {
            $song .= "\\break";
        }
        $song .= "\\includegraphics[page=$page]{$songfile-$md5-crop.pdf}\n";
    }
    
    &processTune($abc, $num, $song);
}


print OUTFILE '\end{document}' . "\n";

close(OUTFILE);

print STDERR "\n";


sub processTune() {
    my $Tune  = shift;
    my $Num   = shift;
    my $Song = shift;

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
            utf8::decode($Title);
            $Title =~ s/[\.\,\;]$//; # Remove trailing punctuation
        }
        if ($Line =~ /^[SNH]:(.*)/) {
            
            #next if $Line =~ /^Q:/;

            my $Text = $1;
            utf8::decode($Text) or die("Cannot reduce to latin1: $Text\n");
            if ($Text =~ /Stämning:\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
                next;
            }
            
            $Text = texSubstitutions($Text);
            
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
    
    $TuneConf{$Num}->{"newpage"} = 1 unless defined $TuneConf{$Num}->{"newpage"};

    my $SpaceBefore  = $TuneConf{$Num}->{"spacebefore"};
    my $SpaceBetween = $TuneConf{$Num}->{"spacebetween"} || 0;
    my $SpaceAfter   = $TuneConf{$Num}->{"spaceafter"} || "1cm";
    my $TitleSpace   = $TuneConf{$Num}->{"titlespace"} || "12pt";
    my $BreakBefore  = $TuneConf{$Num}->{"newpage"} || 0;
    my $BreakAfter   = $TuneConf{$Num+1}->{"newpage"};

    print OUTFILE "\n\n";

    print OUTFILE "\\newpage\n" if $BreakBefore;

    if (my $subsection = $TuneConf{$Num}->{"subsection"}) {
        print OUTFILE "\\section*{\\centering $subsection}\\vspace{1cm}\n";
    }

    # Title and text
    if ($Title) {
        print OUTFILE "\\tunename{$Title}{$TitleSpace}\n";
    }
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
    
    if (-e "text/song-$Num.tex") {
        $Source = &slurp("text/song-$Num.tex");
        utf8::decode($Source) or die("Cannot reduce to latin1: $Source\n");
    }
    $PostText = &slurp("text/text-$Num.tex") if (-e "text/text-$Num.tex");
    utf8::decode($PostText);
    
    # Extra vertical before score
    print OUTFILE "\\vspace*{$SpaceBefore}\n" if $SpaceBefore;

    if ($MultipleLines) {
        print OUTFILE "\\begin{flushright} \\parbox{$TextBox}{$Source} " .
            "\\end{flushright}\n\n";
    } else {
        print OUTFILE "\\begin{flushright} $Source \\end{flushright}\n\n";
    }

    # Extra vertical space between text and score
    print OUTFILE "\\vspace{$SpaceBetween}\n" if $SpaceBetween;

    print OUTFILE $Song;

    @Lyrics = split("\n", &slurp("text/lyrics-$Num.tex")) if (-e "text/lyrics-$Num.tex");
    if (@Lyrics) {
        my $First = 1;
        print OUTFILE "\\break\n";
        print OUTFILE "\\vspace{0.3cm}\n";
        print OUTFILE "\\begin{flushleft}\n";
        foreach my $Line (@Lyrics) {
            next unless $Line =~ /\S/;
            utf8::decode($Line) or die("Bad utf8 sequence!");
            $Line = texSubstitutions($Line);
            #$Line =~ s/»(?!\s)/»\\tinyskip{}/g;
            #$Line =~ s/(?<!\s)»/\\tinyskip{}»/g;
            $First = 1 if $Line =~ /\\columnbreak\s*$/;
            if ($Line =~ /^(\d+)\.?\s*(.*)/) {
                print OUTFILE "\\vspace{0.3cm}\n" unless $First;
                print OUTFILE "\\tabto{1.2cm}$1.\\tabto{2cm}$2\n";
                $First = 0;
            } else {
                print OUTFILE "\\tabto{2cm}$Line\n";
            }
        }
#        $Lyrics =~ s/\n\n/\\par\n/g;
#        $Lyrics =~ s/^ /\\tabto*{4cm}/mg;

        #print OUTFILE "\\hangindent=1cm\n";
        print OUTFILE "\\end{flushleft}\n";
    }

    if ($PostText) {
        $PostText = texSubstitutions($PostText);
        #print OUTFILE "\\vspace{0.7cm}\n";
        print OUTFILE "\\begin{center}\n";
        print OUTFILE "\\parbox{16cm}{$PostText}\n\n";
        print OUTFILE "\\end{center}\n";
        #print OUTFILE "\\break\n";
        #print OUTFILE "\\parbox{16cm}{$PostText}\n";
        #print OUTFILE "\\vspace{0.3cm}\n";
    }
    
    if (!$SpaceAfter || $SpaceAfter eq "0cm" || $BreakAfter) {
        $SpaceAfter = "";
    } else {
        $SpaceAfter = "\n\n\\vspace{$SpaceAfter}\n\n";
    }
    
    my $line = $TuneConf{$Headers{'X'}}->{"line"};
    unless (defined $line && $line == 0) {
        my $lineoffset = $TuneConf{$Headers{'X'}}->{"lineoffset"} || 0;
        $lineoffset += 10;
        $lineoffset -= 5 unless $BreakBefore && $BreakAfter;
        print OUTFILE '\begin{center}' . "\n";
        print OUTFILE '\kern' . $lineoffset . 'pt' if $lineoffset; # e.g. 5pt
        print OUTFILE '\line(1,0){180}' . "\n";
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

sub texSubstitutions() {
    my $Text = shift;

    $Text =~ s/(Uppt|Omkr|Meddel|Skoll|Kapt|Joh|Nikl|And|övers|sv|enl)\. /\1.\\\@ /ig;
    $Text =~ s/m\. m\./m.\\\,m./g; # TODO: lookahead for next sentence
    $Text =~ s/t\. f\./t.\\\,f./g; # TODO: lookahead for next sentence
    $Text =~ s/m\. fl\. (?=[a-z])/m.\\\,fl.\\@ /g;
    $Text =~ s/m\. fl\./m.\\\,fl./g;
    $Text =~ s/f\. d\./f.\\\,d.\\\@/g; # TODO: lookahead for next sentence
    $Text =~ s/o\. s\. v\./o.\\\,s.\\\,v.\\\@/g; # TODO: lookahead for next sentence
    $Text =~ s/ fr\. / fr.\\\@ /g;
    $Text =~ s/ Ol\. / Ol.\\\@ /g;
    $Text =~ s/ Joh\. / Joh.\\\@ /g;
    $Text =~ s/d\. ([yä])\./d.\\\,\1./g; # TODO: lookahead for next sentence
    $Text =~ s/ f\. / f.\\\@ /g; # TODO: lookahead for next sentence
    $Text =~ s/([\s\n])\-\-([\s\n])?/$1---$2/g;
    $Text =~ s/(\d)\-(\d)/$1--$2/g;
    $Text =~ s/–/--/g;
    $Text =~ s/—/---/g;
    $Text =~ s/ʃ/\\textesh{}/g;
    $Text =~ s/ɷ/\\textcloseomega{}/g;
    $Text =~ s/’/\'/g;

    $Text =~ s/¼/\\sfrac{1}{4}/g;

    return $Text;
}
