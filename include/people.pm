package People;

use strict;
use warnings;
use utf8;
use open IO => ':utf8';
use Exporter 'import';

our @EXPORT = qw(initPeople %People %ReversePeople getReversePeople);

our %People;
our %ReversePeople;

our %TuneSpecific = (
    218 => {"fanjunkar Lindbom" => "Lindbom"},
    234 => {"O. Laugren" => "Laugren", "»Florsen»" => "Florsen"},
    414 => {"båtsman »Kajuta»" => "Kajutan"},
    418 => {"O. Laurin" => "Laurin-Olof"}
);

sub initPeople($) {
    my $SourceDir = shift;

    opendir(my $dh, $SourceDir) || die("Can't read people from $SourceDir ");
    while(my $FileName = readdir $dh) {
        next unless $FileName =~ /^(.+)\.tex$/;
        my $Name = $1;
        my $Text = &slurp($SourceDir . $FileName);
        &processPerson($Name, $Text);
    }
    closedir $dh;
}

sub getReversePeople($) {
    my $TuneNum = shift;

    die "No \$TuneNum" unless $TuneNum;

    return $TuneSpecific{$TuneNum} || \%ReversePeople;
}


sub slurp() {
    my $filename = shift;
    local $/;
    open(my $fh, "<", $filename) or die("Can't open $filename for slurping");
    # print STDERR "$filename\n";
    my $data = <$fh>;
    close($fh);
    return $data;
}

sub processPerson() {
    my $FileName = shift;
    my $Text = shift;

    my $Name = $1 if $Text =~ /\\textbf\{(.*?)\}/;

    # Generate reverse-lookup-table for names
    $ReversePeople{$Name} = $FileName if $Name;
    if ($Name) {
        if ($Name =~ /^(.*), (\S+)\s*$/) {
            $ReversePeople{"$2 $1"} = $FileName;
        } elsif ($Name =~ /^(.*), ((\S+)\s+.*)$/) {
            $ReversePeople{"$2 $1"} = $FileName;
            $ReversePeople{"$3 $1"} = $FileName;
        }
    }

    my @Tunes;
    if ($Text =~ /^((?:\d+(?:\,? *))+)$/m) {
        my $Tunes = $1;
        $Tunes =~ s/\s*$//;
        @Tunes = split(/,\s*/, $Tunes);
    }

    $People{$FileName} = {
        name => $Name,
        filename => $FileName,
        tunes => \@Tunes
    }
}

1;

