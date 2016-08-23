#!/usr/bin/perl

use warnings;
use strict;

my $inPattern = "abc/song-%d.abc";
my $outPattern = "ly/notes-%d.ly";
my $lyricsPattern = "text/lyrics-%d.tex";

my $From = $ARGV[0];
my $To   = $ARGV[1] || $From;

die("Usage: generate-ly-notes.pl fromtune [totune]\n") unless $From && $To;

for my $i ($From..$To) {
    # open(my $in, "<", sprintf($inPattern, $i));
    # system("abc2ly", "-o" sprintf($outPattern, $i), sprintf($inPattern, $i));
    
    open(my $in, "<", sprintf($inPattern, $i));
    local $/;
    my $tune = <$in>;
    close($in);
    
    open(OUTFILE, '>', sprintf($outPattern, $i));
    &processTune($tune, $i);
    close(OUTFILE);
}

sub processTune() {
    my $Tune = shift;
    my $Num  = shift;

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
    my $Lyrics = '';
    my @MoreLyrics;
    foreach my $Line (@Lines) {
        $Line =~ s/\%.*$//mg;     # Remove comments
        
        if ($Line =~ /^w:(.*)/) {
            $Lyrics .= "$1\n";
            next;
        }
        if ($Line =~ /^W:(.*)/) {
            push(@MoreLyrics, $1);
            next;
        }

        if (defined $Music) {
            $Music .= "$Line\n";
            next;
        }

        my $OriginalLine = $Line;
        $Line =~ s/\^/\\\^\{\}/g;    # Replace circumflex
        $Line =~ s/\»/''/g;          # Replace quote marks (guillemotright)
        
        if ($Line =~ /^([ML]):(\S*)/) {
            $Headers{$1} = $2;
        }
        if ($Line =~ /^T:(.*)/) {
            $Title = $1;
        }
        if ($Line =~ /^[SNH]:(.*)/) {
            
            my $Text = $1;
            if ($OriginalLine =~ /Stämning:\s*(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
                my $Tuning = &convertNote($1) . " " . &convertNote($2) . " ";
                $Tuning   .= &convertNote($3) . " " . &convertNote($4) . " ";
                $Headers{"tuning"} = $Tuning;
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
    
    &createMusic(\%Headers, $Music, $Lyrics);

    if (@MoreLyrics) {
        open(LYRICSFILE, '>', sprintf($lyricsPattern, $Num)) or die("Could note open lyrics file");
        my $Verse = 0;
        my $Indent = 0;
        foreach my $Line (@MoreLyrics) {
            if ($Line =~ /^(\d+)(\.\s+)(.*)/) {
                $Verse = $1;
                $Indent = 4; #length($1 . $2) + 1;
                print LYRICSFILE "$1. ";
                print LYRICSFILE " " if $Verse < 10;
                print LYRICSFILE "$3\n";
                next;
            }
            if ($Line =~ /^(\s*)\S/ && length($1) > $Indent) {
                my $s = " " x $Indent;
                $Line =~ s/^\s*/$s\\qquad{}/;
                print LYRICSFILE "$Line\n";
                next;
            }
            my $s = " " x $Indent;
            $Line =~ s/^\s*/$s/;
            print LYRICSFILE "$Line\n";
        }
        close(LYRICSFILE);
    }
    
#    print OUTFILE "\\vspace{0.5cm}\n\n" unless $BreakAfter;
}

sub createMusic() {
    my $Headers = shift();
    my $Notes   = shift();
    my $Lyrics  = shift();

    my @Items;

    my $CurrentKeyNum;
    my $CurrentKey;
    my $CurrentMeter;
    my $FullBar;
    
    # Get standard note length
    my $LengthFactor = 1;
    $LengthFactor = 2 if ($Headers->{'L'} eq '1/8');
    $LengthFactor = 4 if ($Headers->{'L'} eq '1/4');
    $CurrentKey = $Headers->{'K'};
    $CurrentKeyNum = &getKeyNum($CurrentKey);
    $CurrentMeter = $Headers->{'M'};
    $FullBar = &getFullBarLength($CurrentMeter);
        
    # Parse the items
    my $startsearch = 0;
    my $inchord = 0;
    my $grace = 0;
    my $begingrace = 0;
    my $beginslur = 0;
    my $nextlengthfactor = 1;
    my $barlength = 0;
    my $begintuplet = 0;
    my $tupletleft;
    my $repeat = 0;
    my $alternative = 0;
    
    my %Item;
    my $LastNote;
    
    push(@Items, {'type' => 'barline', 'barline' => '' });
    my $LastBarLine = $Items[0];
    my $LastThickBarLine = $Items[0];

    $_ = $Notes;
  LOOP:
    {
        
        if (/\G[\"\^_=A-Ga-gzLTHMPuv\.]/) {      # A note
            my $note;
            my $acc;
            my $length;
            $Item{'type'} = 'note';
            $Item{'gchord'} = $1 if /\G\"([^\"]*)\"/gc;
            $Item{'accents'} = $1 if /\G([LTHMPuv\.]+)/gc;
            $acc = &convertAccidental($1) if /\G([\^_=]+)/gc;
            $note = $1 if /\G([A-Ga-gz][\,\']*)/gc;
            $Item{'type'} = 'rest', $note = 4 unless defined $note;
            $length = $1 if /\G([\/0-9]+)/gc;
            $length = 1 unless defined $length;
            if ($length eq '/') { $length = 0.5 }
            if ($length =~ /(\d+)\/(\d+)/) { $length = $1 / $2 }
            $length *= $LengthFactor;
            
            if ($inchord < 2) {  # Not in a chord or main note in chord
                $length *= $nextlengthfactor;
                $Item{'reallength'} = $length;
                $Item{'reallength'} = 0 if $begintuplet; # Assumes triplet
                $Item{'reallength'} = 0 if $grace;              
            }

            $nextlengthfactor = 1 unless $inchord;

            $Item{'grace'} = $grace;
            if ($begingrace) {
                $Item{'begingrace'} = 1;
                $begingrace = 0;
            }
           
            if ($begintuplet) {
                $Item{'begintuplet'} = $begintuplet;
                $begintuplet = 0;
            }
            $tupletleft-- if defined $tupletleft;
            if (defined $tupletleft && $tupletleft == 0) {
                $Item{'endtuplet'} = 1;
                undef $tupletleft;
            }

            if ($beginslur) {
                $Item{'beginslur'} = 1;
                $beginslur = 0;
            }
            
            if ($inchord == 0) {
                # Add as single note
                $Item{'notes'} = [];
                push(@{$Item{'notes'}},
                     {'note' => $note, 'acc' => $acc, 'len' => $length});
                $Item{'length'} = $length;
                $barlength += $Item{'reallength'};
                push(@Items, {%Item});
                %Item = ();
                $LastNote = $Items[$#Items];
            } elsif ($inchord == 1) {
                # First in a chord
                $Item{'notes'} = [];
                push(@{$Item{'notes'}},
                     {'note' => $note, 'acc' => $acc, 'len' => $length});
                $inchord = 2;
            } else {
                # In a chord (not first)
                push(@{$Item{'notes'}},
                     {'note' => $note, 'acc' => $acc, 'len' => $length});
            }
            
            redo LOOP;
        }
        
        if (/\G\s*(\|\|)(\d*)\s*/gc or /\G\s*(\[\|)(\d*)\s*/gc or
            /\G\s*(\|\])(\d*)\s*/gc or /\G\s*([\|\:]+)(\d*)\s*/gc) { # Bar line

            # Note above: must look for specific combinations,
            # otherwise [ and ] will be matched as chord delimiters
            #$LastNote->{'spaceafter'} = 1;
            $Item{'type'} = 'barline';
            $Item{'barline'} = $1;
            $Item{'beginrepeat'} = 1 if $1 eq '::' or $1 eq '|:';
            $Item{'endrepeat'} = 1 if $1 eq '::' or $1 eq ':|';
            $Item{'endrepeat'} = 0 if $alternative == 2;
           
            if (($alternative && $Item{'endrepeat'}) || $alternative == 2) {
                my %AItem;
                $AItem{'type'} = 'endalt';
                $AItem{'alternative'} = $alternative;
                $repeat = 0;  # testing
                $alternative = 0;
                push(@Items, \%AItem);
            }

            push(@Items, {%Item});
            if ($barlength != $FullBar) {
                $LastBarLine->{'partial'} = $barlength;
            }
            $LastBarLine = $Items[$#Items];
            $barlength = 0;
            
            if ($Item{'endrepeat'} && $repeat == 0) {
                $LastThickBarLine->{'beginrepeat'} = 1;
            }
            
            $repeat = 0 if $Item{'endrepeat'};
            $repeat = 1 if $Item{'beginrepeat'};

            if (length($1) > 1 && $1 ne '||') {
                # Should || be treated as a thick barline, i e
                # be used as a emergency forward repeat?
                $LastThickBarLine = $Items[$#Items];
            }
            %Item = ();

            if ($2) {
                $Item{'type'} = 'beginalt';
                $Item{'alternative'} = $2;
                $alternative = $2;
                $repeat = 1 if $2 > 1;
                push(@Items, {%Item});
                %Item = ();
            }

            redo LOOP;
        }
        
        if (/\G\[(\d+)/gc) {                   # Alternate ending

            $Item{'type'} = 'beginalt';
            $Item{'alternative'} = $1;
            $repeat = 1 if $1 > 1;
            $alternative = $1;
            push(@Items, {%Item});
            %Item = ();

            redo LOOP;
        }

        if (/\G\[/gc) {                        # Begin chord
            
            $inchord = 1;
            redo LOOP;
        }
        
        if (/\G\]([\/0-9]*)/gc) {              # End chord
            
            my $length = $1;
            $length = 1 unless ($length);
            if ($length eq '/') { $length = 0.5 }
            if ($length =~ /(\d+)\/(\d+)/) { $length = $1 / $2 }
            # $length *= $LengthFactor; # already applied
            $length *= $nextlengthfactor;

            foreach my $note (@{$Item{'notes'}}) {
                $note->{'len'} *= $length;
            }

            $Item{'length'} = $Item{'notes'}->[0]->{'len'};
            $Item{'reallength'} = $Item{'notes'}->[0]->{'len'};
            $Item{'reallength'} = 0 if $begintuplet; # Assumes triplet
            $Item{'reallength'} = 0 if $grace;

            $nextlengthfactor = 1;

            # Add the previously built note chord item
            $barlength += $Item{'reallength'};
            push(@Items, {%Item});
            %Item = ();
            $LastNote = $Items[$#Items];
            $inchord = 0;
            redo LOOP;
        }
        
        if (/\G\((\d+)/gc) {

            $begintuplet = $1;
            $tupletleft = $1;
            redo LOOP;
        }

        if (/\G\(/gc) {                        # Begin slur
            
            $beginslur = 1;
            redo LOOP;
        }
        
        if (/\G\)/gc) {                        # End slur
            
            $Items[$#Items]->{'endslur'} = 1;   
            redo LOOP;
        }

        if (/\G\{/gc) {                        # Begin grace notes
            
            $grace = 1;
            $begingrace = 1;
            redo LOOP;
        }

        if (/\G\}/gc) {                        # End grace notes
            
            $grace = 0;
            $LastNote->{'endgrace'} = 1;
            redo LOOP;
        }
        
        if (/\G\-/gc) {                        # Tie
            
            redo LOOP if $inchord;
            $Items[$#Items]->{'tied'} = 1;
            redo LOOP;
        }
        
        if (/\G(<<|>>|<|>)/gc) {                    # < or >
            
            if ($inchord) {
                print STDERR "*** Error: $1 in chord (tune $Headers->{'X'})\n";
                redo LOOP;
            }

            my $prev;
            $prev = 0.5 if $1 eq '<';
            $prev = 1.5 if $1 eq '>';
            $prev = 0.25 if $1 eq '<<';
            $prev = 1.75 if $1 eq '>>';
            
            $Items[$#Items]->{'length'} *= $prev;
            $Items[$#Items]->{'reallength'} *= $prev;
            foreach my $note (@{$Items[$#Items]->{'notes'}}) {
                $note->{'len'} *= $prev;
            }
            $nextlengthfactor = 2 - $prev;
            redo LOOP;
        }
        
        if (/^\G([A-Za-z]):(.*)/mgc) {         # An in-tune field (eg a key change)
            if ($1 eq 'K') {
                $Item{'type'} = 'key';
                $Item{'key'} = $2;
            } elsif ($1 eq 'M') {
                $Item{'type'} = 'meter';
                $Item{'meter'} = $2;
            } else {
                $Item{'type'} = 'field';
                $Item{'field'} = $1;
                $Item{'value'} = $2;
            }
            push(@Items, {%Item});
            %Item = ();
            redo LOOP;
        }
        
        if (/\G\s+/gc) {                       # Space
            
            redo LOOP if $inchord;
            #$LastNote->{'spaceafter'} = 1;
            redo LOOP;
        }
        
        # Skip and ignore 1 char if unrecognized
        redo LOOP if (/\G./gc);
    }

    if ($repeat) {
        $LastBarLine->{'endrepeat'} = 1;
    }

##########################################################################
##########################################################################

    print OUTFILE "{\n" if $Lyrics;

    if ($Headers->{'tuning'}) {
        print OUTFILE '\override Stem ' . "#'stencil = ##f\n";
        print OUTFILE '\override Score.TimeSignature ';
        print OUTFILE "#'stencil = ##f\n";
        print OUTFILE '\partial 4' . "\n";
        print OUTFILE ' < ' . $Headers->{'tuning'} . ' >4^\markup ';
        print OUTFILE '{ \center-align { \italic "StÃ¤mning." } }' . "\n";
        print OUTFILE '\revert Stem ' . "#'stencil\n";
        print OUTFILE '\revert Score.TimeSignature ' . "#'stencil\n";
        print OUTFILE '\bar "||"' . "\n\n";
    }
    #print OUTFILE "\\override Staff.StaffSymbol #'thickness = #0.9\n";

    # print OUTFILE '\clef treble' . "\n";
    
    $CurrentMeter = '4/4' if $CurrentMeter eq 'C';
    print OUTFILE '\time ' . $CurrentMeter .  "\n";
    print OUTFILE '\key ' . &convertKey($CurrentKey) . "\n";
#
    my $UpStep = 1;
    my $LastLength = 0;
    
    my %Accidentals = ();
    
    foreach my $Item (@Items) {
        if ($Item->{'type'} eq 'note') {

            if ($Item->{'begingrace'}) {
                print OUTFILE ' \acciaccatura { ';
            }
            if ($Item->{'begintuplet'}) {
                print OUTFILE ' \times 2/3 { ' if $Item->{'begintuplet'} == 3;
            }
            if (scalar @{$Item->{'notes'}} == 1) {  # Single note
                my $note = $Item->{'notes'}->[0];
                my $Accidental = $Accidentals{$note->{'note'}}; # Get previous
                if (defined $note->{'acc'}) {
                    $Accidental = $note->{'acc'};
                    $Accidentals{$note->{'note'}} = $Accidental;
                }
                print OUTFILE &convertNote($note->{'note'},
                                           $Accidental,
                                           $CurrentKeyNum);
            } else {   # Chord
                print OUTFILE "< ";
                foreach my $note (@{$Item->{'notes'}}) {
                    print OUTFILE &convertNote($note->{'note'},
                                               $note->{'acc'},
                                               $CurrentKeyNum) . ' ';
                }
                print OUTFILE " >";
            }
            if ($Item->{'length'} != $LastLength) {
                print OUTFILE &convertLength($Item->{'length'});
                $LastLength = $Item->{'length'};
            }
            #if ($Headers->{'X'} == 231) {  ######  ******** ########
            #    my $note = $Item->{'notes'}->[0];
            #    print STDERR $note->{'note'} . $Item->{'length'} . " ";
            #}
            
            if ($Item->{'tied'}) {
                print OUTFILE '-~';
            }
            if ($Item->{'endslur'}) {
                print OUTFILE '-)';
            }
            if ($Item->{'beginslur'}) {
                print OUTFILE '-(';
            }
            if ($Item->{'accents'}) {
                print OUTFILE '->' if $Item->{'accents'} =~ /L/;
                print OUTFILE '-.' if $Item->{'accents'} =~ /\./;
                print OUTFILE '-\fermata' if $Item->{'accents'} =~ /H/;
                print OUTFILE '-\smallFlageolet' if $Item->{'accents'} =~ /o/;
                print OUTFILE '-\upbow' if $Item->{'accents'} =~ /u/;
                print OUTFILE '-\downbow' if $Item->{'accents'} =~ /v/;
            }
            # if ($Item->{'gchord'}) {
            #     print OUTFILE '_"' . $Item->{'gchord'} . '"';
            # }

            if ($Item->{'endtuplet'}) {
                print OUTFILE ' } ';
            }
            if ($Item->{'endgrace'}) {
                print OUTFILE ' } ';
            }
        }
        
        if ($Item->{'type'} eq 'barline') {

            #print STDERR "\n" if $Headers->{'X'} == 231;

            my $BarLine = $Item->{'barline'};
            if ($BarLine) {
                if (!$Item->{'endrepeat'} && $BarLine eq '|]') {
                    print OUTFILE '\bar "|." |';
                } elsif ($BarLine eq '||') {
                    print OUTFILE '\bar "||" |'
                } elsif ($BarLine eq '|') {
                    print OUTFILE ' | ';
                }
                $UpStep = 0;
            }
            # if ($UpStep && $Item->{'partial'}) {
            #     print OUTFILE "\n" . '\partial 16*' . $Item->{'partial'};
            #     #&convertLength($Item->{'partial'});
            # }

            # Repeats
            if ($Item->{'endrepeat'}) {
                print OUTFILE " |\n" . ' } %( endrepeat )% ';
            }
            if ($Item->{'beginrepeat'}) {
                print OUTFILE "\n" . '\repeat volta 2 { ';
            }

            print OUTFILE "\n";
            
            %Accidentals = ();
        }

        if ($Item->{'type'} eq 'beginalt') {
            if ($Item->{'alternative'} == 1) {
                print OUTFILE ' } ' . "\n" . '\alternative { ' . "\n" . ' { ';
            } else {
                print OUTFILE "\n" . " { % beginalt\n";
            }
        }

        if ($Item->{'type'} eq 'endalt') {
            if ($Item->{'alternative'} == 2) {
                print OUTFILE ' }} ' . "\n";
            }
        }

        if ($Item->{'type'} eq 'key') {
            $CurrentKey = $Item->{'key'};
            $CurrentKeyNum = &getKeyNum($CurrentKey);
            print OUTFILE '\key ' . &convertKey($CurrentKey) . "\n";
        }
        
        print OUTFILE " ";
    }

    if ($Lyrics) {
        print OUTFILE "}\n";
        print OUTFILE " \\addlyrics {\n";
        # print OUTFILE "     \\set fontSize = #-2\n";
        print OUTFILE '     \set stanza = #"1. "' . "\n" if $Lyrics =~ /^1\./;
        $Lyrics =~ s/^\d\.[\s\~]*//; # remove stanza
        $Lyrics =~ s/\-/ -- /g;
        $Lyrics =~ s/_/ __/g;
        $Lyrics =~ s/^(.)/     $1/mg;
        #utf8::encode($Lyrics);
        print OUTFILE $Lyrics;
        print OUTFILE "}\n";
    }
    
#    print OUTFILE "} }\n\n";

}


sub getKeyNum() {
    my $Key = shift();
    
    my $Num = 0;
    $Key =~ /^([A-G][\#b]?)([m]?)/;
    $Num = -6 if $1 eq 'Gb';
    $Num = -5 if $1 eq 'Db';
    $Num = -4 if $1 eq 'Ab';
    $Num = -3 if $1 eq 'Eb';
    $Num = -2 if $1 eq 'Bb';
    $Num = -1 if $1 eq 'F';
    $Num =  0 if $1 eq 'C';
    $Num =  1 if $1 eq 'G';
    $Num =  2 if $1 eq 'D';
    $Num =  3 if $1 eq 'A';
    $Num =  4 if $1 eq 'E';
    $Num =  5 if $1 eq 'B';
    $Num =  6 if $1 eq 'F#';
    $Num =  7 if $1 eq 'C#';
    $Num =  8 if $1 eq 'G#';
    $Num =  9 if $1 eq 'D#';

    $Num -= 3 if $2 eq 'm';

    return $Num;
}

sub convertKey() {
    my $Source = shift();
    
    $Source =~ /([A-G])([\#b])?\s*(.*)/;

    my $Root = lc($1);
    {
        no warnings;
        $Root .= 'is' if $2 eq '#';
        $Root .= 'es' if $2 eq 'b';
    }
    my $Mode = ' \major';
    $Mode = ' \minor' if $3 eq 'm';

    return $Root . $Mode;
}

sub convertNote() {
    my $Source     = shift();
    my $Accidental = shift();
    my $Key        = shift();

    # Special handling if we get a "raw" note (e g from the fiddle-tuning code)
    while ($Source =~ s/\^//) {
        $Accidental++;
    }
    while ($Source =~ s/_//) {
        $Accidental--;
    }

    my $base = '';
    my $octava = '';
    if ($Source =~ /^([a-g])(\'*)/) {
        $base = $1;
        $octava = "''" . $2;
    } elsif ($Source =~ /^([A-G])(\,*)/) {
        $base = lc($1);
        $octava = "'" . $2;
        $octava =~ s/\'\,//;
    } elsif ($Source eq 'z') {
        $base = 'r';
    } else {
        die "Bad note ($Source)";
    }
    my $acc = '';
    unless ($base eq 'r') {
        unless (defined $Accidental) {
            no warnings;
            $Accidental = 1  if ($base eq 'f') && $Key >= 1;
            $Accidental = 1  if ($base eq 'c') && $Key >= 2;
            $Accidental = 1  if ($base eq 'g') && $Key >= 3;
            $Accidental = 1  if ($base eq 'd') && $Key >= 4;
            $Accidental = 1  if ($base eq 'a') && $Key >= 5;
            $Accidental = -1 if ($base eq 'e') && $Key >= 6;
            $Accidental = -1 if ($base eq 'b') && $Key <= -1;
            $Accidental = -1 if ($base eq 'e') && $Key <= -2;
            $Accidental = -1 if ($base eq 'a') && $Key <= -3;
            $Accidental = -1 if ($base eq 'd') && $Key <= -4;
            $Accidental = -1 if ($base eq 'g') && $Key <= -5;
            $Accidental = -1 if ($base eq 'c') && $Key <= -6;
        }
        {
        no warnings;
            $acc = 'is' x $Accidental    if $Accidental > 0;
            $acc = 'es' x (-$Accidental) if $Accidental < 0;
        }
    }
    return $base . $acc . $octava;
}

sub convertLength() {
    my $Source = shift();

    return "32"  if $Source == 0.5;
    return "16"  if $Source == 1;
    return "16." if $Source == 1.5;
    return "8"   if $Source == 2;
    return "8."  if $Source == 3;
    return "8.." if $Source == 3.5;
    return "4"   if $Source == 4;
    return "4."  if $Source == 6;
    return "4.." if $Source == 7;
    return "2"   if $Source == 8;
    return "2."  if $Source == 12;
    return "1"   if $Source == 16;
    print STDERR "bad length: $Source\n";
    return "";
}

sub convertAccidental() {
    my $Source = shift();
    
    return 0 if $Source eq '=';
    return 1 if $Source eq '^';
    return 2 if $Source eq '^^';
    return -1 if $Source eq '_';
    return -2 if $Source eq '__';
    return undef;
}

sub getFullBarLength() {
    my $Meter = shift();

    return 12 if $Meter eq '3/4';
    return 16 if $Meter eq '4/4' or $Meter =~ /^C/;
    return 8 if $Meter eq '2/4';
}
