package Hyphenation;

use utf8;


# %Hyphenation::Words is set below

@Hyphenation::Words = (
    "an-to-go",
    "an-mod-ad",
    "bröllops-hög-tid-lig-heterna",
    "dans-till-ställ-ningar",
    "fämtio-riks-dalers-sedel",
    "Grodda-karl-ar-na",
    "hop-lägg-nings-ka-la-ser",
    "Stånds-per-so-ner",
    "spel-mans-släkt",
    "vete-mjöl",
    "åter-vägen"
);


foreach my $Word (@Hyphenation::Words) {
    my $Solid = $Word;
    $Solid =~ s/\-//g;
    $Hyphenation::Words{$Solid} = $Word;
}


1;
