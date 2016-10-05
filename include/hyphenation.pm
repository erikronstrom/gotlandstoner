package Hyphenation;

use utf8;


# %Hyphenation::Words is set below

@Hyphenation::Words = (
    "hop-lägg-nings-ka-la-ser",
    "Stånds-per-so-ner",
    "vete-mjöl",
    "Grodda-karl-ar-na",
    "an-to-go",
    "an-mod-ad",
    "fämtio-riks-dalers-sedel"
);


foreach my $Word (@Hyphenation::Words) {
    my $Solid = $Word;
    $Solid =~ s/\-//g;
    $Hyphenation::Words{$Solid} = $Word;
}


1;
