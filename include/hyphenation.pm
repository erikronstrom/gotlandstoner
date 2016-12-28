package Hyphenation;

use utf8;


# %Hyphenation::Words is set below

@Hyphenation::Words = (
    "an-to-go",
    "an-mod-ad",
    "brud-huset",
    "bröllops-gäster",
    "bröllops-hög-tid-lig-heterna",
    "bröl-lops-marscher",
    "bud-ande",
    "dans-till-ställ-ningar",
    "fämtio-riks-dalers-sedel",
    "Grodda-karl-ar-na",
    "hop-lägg-nings-ka-la-ser",
    "hög-tidlig",
    "rid-marsch-erna",
    "Stånds-per-so-ner",
    "Spel-mannen",
    "spel-mans-släkt",
    "spel-männen",
    "vete-mjöl",
    "åter-vägen",
    "över-ens-stämma"
);


foreach my $Word (@Hyphenation::Words) {
    my $Solid = $Word;
    $Solid =~ s/\-//g;
    $Hyphenation::Words{$Solid} = $Word;
}


1;
