#!/usr/bin/perl
use strict;
no integer;

use utf8;
use open IO => ':utf8';

#use Getopt::Long;
use Digest::MD5;
use JSON;

my $Config = &slurp('config.json');
utf8::encode($Config);
$Config = decode_json($Config);


my $BookNum;
my $From = $ARGV[0];
my $To   = $ARGV[1];
my $Preface = "";
my $Postface = "";
my $TitlePageLineWidth = 200;

if ($ARGV[0] eq 'book') {
    my $Book = $ARGV[1]-1;
    die("No such book!\n") unless $Config->{"books"}->[$Book];
    $BookNum  = $ARGV[1];
    $From     = $Config->{"books"}->[$Book]->{"from"};
    $To       = $Config->{"books"}->[$Book]->{"to"};
    $Preface  = '\input{text/' . $Config->{"books"}->[$Book]->{"preface"} . '}';
    $Postface = $Config->{"books"}->[$Book]->{"postface"};
    $TitlePageLineWidth = $Config->{"books"}->[$Book]->{"linewidth"} || $TitlePageLineWidth;
}

die() unless $From && $To;

system("bin/generate-ly-songs.pl", $From, $To);


##############################################################

my %TuneConf = %{$Config->{"tunes"}};
my @Sections;
foreach my $num (sort keys %{$Config->{"sections"}}) {
    if ($num >= $From and $num <= $To) {
        my $name = $Config->{"sections"}->{$num}->{"name"};
        push(@Sections, '{\huge\textls[80]{' . $name . '}\par}');
    }
}

# open(CONFIG, '<', 'config');
# while(<CONFIG>) {
#     next unless /^(\d+):\s*(.+)$/;
#     my $Tune = $1;
#     my $Conf = $2;
#     my @Conf = split(/\s*,\s*/, $Conf);
#     foreach my $C (@Conf) {
#         $C =~ /(\w+)\s*=\s*(.+)/;
#         $TuneConf{$Tune}->{$1} = $2;
#         if ($1 eq "section" and ($Tune >= $From) and ($Tune <= $To)) {
#             my $section = $2;
#             $section =~ s/\\+[\w{\(\)\.}]+//g;
#             $section =~ s/[{}]//g;
#             $section =~ s/\(\w+\)//g;
#             $section = ucfirst(lc($section));
#             $section = '{\huge\textls[80]{' . $section . '}\par}';
#             push(@Sections, $section);
#         }
#     }
# }
# close(CONFIG);

# for my $num (214..420) {
#     print "$num " unless $TuneConf{$num}->{'newpage'} == 1;
# }
# print "\n";
# exit();


open(OUTFILE, '>', 'book/fredin.latex') or die("Could not open fredin.latex for writing: $!");

my $template = &slurp("include/book-template.latex");
my $titlePage = &slurp("include/title-page-template.latex");
my $back = &slurp("include/back-template.latex");

my %params;
$params{"from"} = $From;
$params{"to"} = $To;
$params{"linewidth"} = $TitlePageLineWidth;
$params{"sections"} = join("\n    ", @Sections);
$params{"preface"} = $Preface;
$params{"postface"} = $Postface;
$params{"booknum"} = $BookNum;

# if (-e "book/title-$From-$To.latex") {
#     $params{"titlepage"} = "\\includepdf{book/title-$From-$To}\n";
# }

$titlePage =~ s/%\(\(([\w\-]+)\)\)%/$params{$1}/ge;
$back =~ s/%\(\(([\w\-]+)\)\)%/$params{$1}/ge;

$params{"titlepage"} = $titlePage;

my $book = $template;
$book =~ s/%\(\(([\w\-]+)\)\)%/$params{$1} || "$1 is UNDEFINED"/ge;

print OUTFILE $book;


for my $num ($From..$To) {
    
    if (my $section = $Config->{"sections"}->{$num}) {
        # $text = uc($section);
        # $section =~ s/\{(\d+)MM\}/{$1mm}/g;
        # $section =~ s/\\VSPACE/\\vspace/g;
        my $text = $section->{"text"};
        my $name = $section->{"name"};
        print OUTFILE "\\cleardoublepage\n";
        print OUTFILE "\\part*{\\textls[100]{$text}}\n";
        print OUTFILE "\\addcontentsline{toc}{section}{$name}\n";
        print OUTFILE "\\markboth{\\MakeUppercase{$name}}{\\MakeUppercase{$name}}\n";

        my $file = $section->{"file"};
        if ($file) {
            my $text = texSubstitutions(&slurp("text/$file"));
            #print OUTFILE "\\begin{center}\n";
            #print OUTFILE "\\parbox{16cm}{ \\setlength{\\parindent}{1.5em} $text}\n";
            # \\leftskip=1cm \\rightskip=1cm
            print OUTFILE "$text \n\n\n";
            #print OUTFILE "\\end{center}\n\n";
        }
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
        system("lilypond", "-l", "WARNING", "--bigpdf", "-d", "gs-load-fonts=\#t", "-o", "$songfile-$md5", "$songfile.ly") unless -e "$songfile-$md5.pdf";
        `pdfcrop $songfile-$md5.pdf`; # Use backticks instead of system() to suppress output
        unlink("$songfile-$md5.pdf");
    }
    my $pages = $TuneConf{$num}->{"pages"} || 1;
    my $song = "";
    for my $page (1..$pages) {
        if ($page > 1) {
            $song .= "\\vfill\\break";
        }
        $song .= "\\includegraphics[page=$page,trim=0.75mm 0 0 0]{$songfile-$md5-crop.pdf}\n";
    }
    
    &processTune($abc, $num, $song);
}

print OUTFILE "$back\n"; # if $BookNum && $BookNum >= 2; # temp

print OUTFILE '\end{document}' . "\n";

close(OUTFILE) or die("Could not close file");

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
        if ($TuneConf{$Num}->{"title"}) {
            $Title = $TuneConf{$Num}->{"title"};
        } elsif ($Line =~ /^T:(.*)/) {
            if ($TuneConf{$Num}->{"hidetitle"}) {
                $Source .= $1 . " ";
            } else {
                $Title = $1;
            }
            # $Title =~ s/[\.\,\;]$//; # Remove trailing punctuation
        }
        if ($Line =~ /^[SNH]:(.*)/) {
            
            #next if $Line =~ /^Q:/;

            my $Text = $1;
            if ($Text =~ /Stämning:\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
                next;
            }
            
            #$Text = texSubstitutions($Text);
            
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

    if (my $subsection = $Config->{"subsections"}->{$Num}) {
        my $text = $subsection->{"text"};
        print OUTFILE "\\section*{\\centering \\LARGE $text}\\vspace{1cm}\n";
        $text =~ s/\.$//;
        print OUTFILE "\\markboth{\\MakeUppercase{$text}}{\\MakeUppercase{$text}}\n";
        print OUTFILE "\\addcontentsline{toc}{subsection}{$text}\n";
    }

    # Title and text
    if ($Title) {
        my $TexTitle = texSubstitutions($Title);
        print OUTFILE "\\tunename{$TexTitle}{$TitleSpace}\n";
    }
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
    $Source = texSubstitutions($Source);
    
    $PostText = &slurp("text/text-$Num.tex") if (-e "text/text-$Num.tex");
    
    # Extra vertical before score
    print OUTFILE "\\vspace*{$SpaceBefore}\n" if $SpaceBefore;

    if ($MultipleLines) {
        print OUTFILE "\\begin{flushright} \\microtypesetup{protrusion=false} \\parbox{$TextBox}{$Source} " .
            "\\end{flushright}\n\n";
    } else {
        print OUTFILE "\\begin{flushright} \\microtypesetup{protrusion=false} $Source \\end{flushright}\n\n";
    }

    # Extra vertical space between text and score
    print OUTFILE "\\vspace{$SpaceBetween}\n" if $SpaceBetween;

    print OUTFILE $Song;

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

    @Lyrics = split("\n", &slurp("text/lyrics-$Num.tex")) if (-e "text/lyrics-$Num.tex");
    if (@Lyrics) {
        my $First = 1;
        print OUTFILE "\\break\n";
        print OUTFILE "\\vspace{0.3cm}\n";
        print OUTFILE "\\begin{flushleft}\n";
        foreach my $Line (@Lyrics) {
            next unless $Line =~ /\S/;
            #$Line =~ s/»(?!\s)/»\\tinyskip{}/g;
            #$Line =~ s/(?<!\s)»/\\tinyskip{}»/g;
            #$First = 1 if $Line =~ /\\columnbreak\s*$/;
            if ($Line =~ /^(\d+)\.?\s*(.*)/) {
                print OUTFILE "\\vspace{0.3cm}\n" unless $First;
                print OUTFILE "\\tabto{0.2cm}$1.\\tabto{0.8cm}" . texSubstitutions($2) . "\n";
                $First = 0;
            } elsif ($Line =~ /^\\\w/) {
                print OUTFILE "$Line\n";
            } else {
                $Line = texSubstitutions($Line);
                print OUTFILE "\\tabto{0.8cm}$Line\n";
            }
        }
#        $Lyrics =~ s/\n\n/\\par\n/g;
#        $Lyrics =~ s/^ /\\tabto*{4cm}/mg;

        #print OUTFILE "\\hangindent=1cm\n";
        print OUTFILE "\\end{flushleft}\n";
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

    $Text =~ s/(Uppt|Omkr|Meddel|Skoll|Kapt|Joh|Nikl|And|övers|sv|enl|mel|saml|arb|handl)\. /\1.\\\@ /ig;
    $Text =~ s/m\. m\./m.\\\,m./g; # TODO: lookahead for next sentence
    $Text =~ s/t\. f\. /t.\\\,f.\\\@ /g; # TODO: lookahead for next sentence
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
    $Text =~ s/ŋ/\\ng{}/g;
    $Text =~ s/ɷ/\\textcloseomega{}/g;
    $Text =~ s/»/\\guillemotright{}/g;
    $Text =~ s/’/\'/g;

    $Text =~ s/¼/\\sfrac{1}{4}/g;

    return $Text;
}

