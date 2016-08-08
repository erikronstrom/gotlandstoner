#!/usr/bin/perl
use strict;
no integer;

my $From = $ARGV[0] || 214;
my $To   = $ARGV[1] || 360;

my $inPattern = "ly/notes-%d.ly";
my $outPattern = "book/song-%d.ly";

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

my $template = &slurp("include/song-template.ly");


for my $num ($From..$To) {
    my $notes = &slurp(sprintf($inPattern, $num));
    my $outfile = sprintf($outPattern, $num);
    
    open(OUTFILE, '>', $outfile) or die("Can't open $outfile for writing!\n");
    
    print STDERR "$num ";
    
    my $BreakBefore = $TuneConf{$num}->{"newpage"} || 0;
    my $BreakAfter  = $TuneConf{$num+1}->{"newpage"};
    
    
    my $SSpacing = $TuneConf{$num}->{"systemspacing"} || 0;
    $SSpacing = 14 + ($SSpacing * 0.5);
    
    my %params;
    $params{'tune-num'} = $num;
    $params{'notes'} = $notes;
    $params{'basic-distance'} = $SSpacing;
    $params{'minimum-distance'} = 11;
    $params{'padding'} = 1;
    
    my $NS = $TuneConf{$num}->{"notespacing"} || 0;
    $params{'note-spacing'} = 6 - $NS;

    my $song = $template;
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

