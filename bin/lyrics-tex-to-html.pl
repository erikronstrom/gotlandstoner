#!/usr/bin/perl
use strict;

use utf8;
use open IO => ':utf8';

my $SourceDir = 'text/';
my $TargetDir = 'text/html/';


opendir(my $dh, $SourceDir) || die;
while(my $FileName = readdir $dh) {
    next unless $FileName =~ /^lyrics-(\d+)\.tex$/;
    my $Num = $1;
    my $Text = &slurp($SourceDir . $FileName);
    open(OUTFILE, '>', $TargetDir . 'lyrics-' . $Num . '.html');
    # print STDERR "$FileName\n";
    &processText($Text);
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


sub processText() {
    my $Text = shift;

    # Remove TeX comments
    $Text =~ s/%.*$//mg;

    # Remove certain TeX commands
    $Text =~ s/\\vspace\*\{.*?\}\n*//g;
    $Text =~ s/\\setlength\{.*?}\{.*?}//g;
    $Text =~ s/\\begin{multicols}{(\d)}\n*//g;
    $Text =~ s/\\end{multicols}//g;
    $Text =~ s/\\vfill//g;
    $Text =~ s/\\columnbreak//g;
    $Text =~ s/\\textls\[\S*\]\{([^\}]*)\}/$1/g;
    $Text =~ s/\\bigskip//g;

    # Footnotes  TODO: save and insert at bottom!
    $Text =~ s/\\footnote\{.*?}//sg;

    # Bold and italic
    $Text =~ s/\\textbf{(.*?)}/<strong>$1<\/strong>/g;
    $Text =~ s/\\textit{(.*?)}/<i>$1<\/i>/g;
    $Text =~ s/\\small\{([^\}]*)\}/<small>$1<\/small>/g;

    # Paragraphs to list items
    # $Text =~ s/^(\d+\.)\s*(.*)$/<\/li>\n<li value="$1">$2/mg;

    # Abbreviations
    $Text =~ s/([a-zåäö]+\.\\,([a-zåäö]+\.\\,)*[a-zåäö]+)\\\@\./<abbr>$1.<\/abbr><span class="sentencespace"> <\/span>/g;
    $Text =~ s/(?<!\\,)(?<!<abbr>)([a-zåäö]+\.\\,([a-zåäö]+\.\\,)*[a-zåäö]+\.)/<abbr>$1<\/abbr>/g;
    #$Text =~ s/\\,/<span class="thinspace">&nbsp;<\/span>/g;
    $Text =~ s/\\,/&nbsp;/g;
    $Text =~ s/\\-/&shy;/g;

    # TeX characters
    $Text =~ s/'/’/g;
    $Text =~ s/---/&mdash;/g;
    $Text =~ s/--/&ndash;/g;
    $Text =~ s/\\textemdash{}/&mdash;/g;
    $Text =~ s/\\textendash{}/&ndash;/g;
    $Text =~ s/\\textesh({})?/ʃ/g;
    $Text =~ s/\\guillemotright({})?/»/g;
    $Text =~ s/\\sfrac\{1\}\{4\}/&frac14;/g;
    $Text =~ s/\\sfrac\{3\}\{4\}/&frac34;/g;

    $Text =~ s/\\qquad\{\}/&emsp;/g;

    $Text =~ s/\n\s*\\tabto\{\S*\}//g;

    my %Verses;
    my $CurrentVerse;
    foreach my $Line (split("\n", $Text)) {
        if ($Line =~ /^(\d+)\.\s+(.*)/) {
            # print STDOUT "VERS!\n";
            $CurrentVerse = $1;
            $Verses{$CurrentVerse} = [$2];
        } elsif ($Line =~ /^\s+(.*)/ && $CurrentVerse) {
            push(@{$Verses{$CurrentVerse}}, $1);
        }
    }

    print OUTFILE "<ol class=\"lyrics\">\n";

    # print OUTFILE %Verses;

    foreach my $Verse (sort {$a <=> $b} keys %Verses) {
        my $Lines = $Verses{$Verse};
        print OUTFILE "  <li value=\"$Verse\">\n    ";
        print OUTFILE join("<br>\n    ", @$Lines);
        print OUTFILE "\n  </li>\n";
    }

    print OUTFILE "</ol>\n";

    # $Text =~ s/\n/<br>\n/g;
    # $Text =~ s/\<br\>\n<\/li\>/aaa<\/li>/gs;
    # $Text =~ s/^\s*<\/li>//s;
    # $Text = $Text . "</li>\n";

    # print OUTFILE $Text;
}

# sub shy() {
#     my $Word = shift;
#     my $Subst = $Hyphenation::Words{$Word};
#     $Subst =~ s/\-/&shy;/g;
#     return $Subst;
# }