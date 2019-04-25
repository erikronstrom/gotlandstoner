#!/usr/bin/perl
use strict;
no integer;

use utf8;
use open IO => ':utf8';
use JSON;

my $From = $ARGV[0] || 214;
my $To   = $ARGV[1] || 360;

my $abcPattern = "abc/song-%d.abc";
my $inPattern = "ly/notes-%d.ly";
my $outPattern = "book/song-%d.ly";

my $svg = $ENV{'svg'};

##############################################################

# my %TuneConf;
# open(CONFIG, '<', 'config');
# while(<CONFIG>) {
#     next unless /^(\d+):\s*(.+)$/;
#     my $Tune = $1;
#     my $Conf = $2;
#     my @Conf = split(/\s*,\s*/, $Conf);
#     foreach my $C (@Conf) {
#         $C =~ /(\w+)\s*=\s*(.+)/;
#         $TuneConf{$Tune}->{$1} = $2;
#     }
# }
# close(CONFIG);
my $Config = &slurp('config.json');
utf8::encode($Config);
$Config = decode_json($Config);
my %TuneConf = %{$Config->{"tunes"}};

my $template = &slurp("include/song-template.ly");


for my $num ($From..$To) {
    my $notes = &slurp(sprintf($inPattern, $num));
    my $outfile = sprintf($outPattern, $num);
    my $abc = &slurp(sprintf($abcPattern, $num));

    $notes =~ s/»/\x{F101}/g;

    my %params;

    if ($abc =~ /^Q:\"(.*)\"$/m && !$TuneConf{$num}->{"hidetempo"}) {
        my $Tempo = $1;
        $params{'tempo'} =
            "\\once \\override Score.RehearsalMark.break-align-symbols = #'(time-signature)\n" .
            "\\once \\override Score.KeySignature.break-align-anchor-alignment = #LEFT\n" .
            "\\once \\override Score.RehearsalMark.self-alignment-X = #LEFT\n" .
            "\\once \\override Score.RehearsalMark.padding = #3\n" .
            "\\mark \\markup { \\italic \\normalsize \"" . $Tempo . "\" }\n\n";
    }
    my $hasTitle = $abc =~ /^T:\w/m;

    
    open(OUTFILE, '>', $outfile) or die("Can't open $outfile for writing!\n");
    
    print STDERR "$num ";

    my $BreakBefore = $TuneConf{$num}->{"newpage"} || 0;
    my $BreakAfter  = $TuneConf{$num+1}->{"newpage"};    
    
    my $SSpacing = $TuneConf{$num}->{"systemspacing"} || 0;
    $SSpacing = 14 + ($SSpacing * 0.5);
    
    my $NumberInText = $TuneConf{$num}->{'numberInText'};

    $params{'indent'} = $NumberInText ? 0 : 0.5 + (length($num) * 0.3);
    $params{'tune-num'} = $num;
    $params{'print-tune-num'} = !$NumberInText;
    $params{'notes'} = $notes;
    $params{'basic-distance'} = $SSpacing;
    $params{'minimum-distance'} = 11;
    $params{'padding'} = 1;
    if ($svg) {
        $params{'tune-num-font'} = ""; # "\\override #'(font-encoding . fetaText)";
        $params{'page-height'} = "600\\mm"; # should be enough for any tune in the collection
        #$params{'margins'} = "    left-margin = 1\\mm\n    right-margin = 1\\mm\n";
        $params{'page-width'} = "    paper-width = 173\\mm\n";
        $params{'page-count'} = "page-count = #1";
    } else {
        my $pages = $TuneConf{$num}->{"pages"};
        $params{'page-count'} = "page-count = #$pages" if $pages;
        my $pageHeight = $TuneConf{$num}->{"pageheight"} || ($hasTitle ? "240mm" : "250mm");
        $pageHeight =~ s/mm/\\mm/;
        $params{'page-height'} = $pageHeight;
    }

    
    if ($num <= 416 || $num >= 645 && ($num != 720)) {
        $params{'time-settings'} =
            "\\overrideTimeSignatureSettings 2/4 1/4 #'(1 1) #'()\n" .
            "\\overrideTimeSignatureSettings 3/4 1/4 #'(1 1 1) #'()\n" .
            "\\overrideTimeSignatureSettings 4/4 1/4 #'(1 1 1 1) #'()\n";
    }
    
    my $NS = $TuneConf{$num}->{"notespacing"} || 0;
    $params{'note-spacing'} = 6 - $NS;

    my $song = $template;
    $song =~ s/%\(\((if|unless)\s+([\w\-]+)\)\)%(.*?)%\(\(endif\)\)%/evalif($1, $2, $3, \%params)/sige;
    $song =~ s/%\(\(([\w\-]+)\)\)%/$params{$1}/ge;
    
    print OUTFILE $song;    
    close(OUTFILE);

}

print STDERR "\n";

sub slurp() {
    my $filename = shift;
    local $/;
    open(my $fh, "<", $filename) or die("Can't open $filename for slurping");
    my $data = <$fh>;
    close($fh);
    return $data;
}

sub evalif($$$) {
    my $op = shift;
    my $var = shift;
    my $block = shift;
    my $params = shift;
    return $block if (($op eq 'if' && $params->{$var}) || ($op eq 'unless' && !$params->{$var}));
    return '';
}
