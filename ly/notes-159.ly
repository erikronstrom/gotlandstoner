\once \override Score.RehearsalMark.break-align-symbols = #'(time-signature)
\once \override Score.KeySignature.break-align-anchor-alignment = #LEFT
\once \override Score.RehearsalMark.self-alignment-X = #LEFT
\once \override Score.RehearsalMark.padding = #3
\mark \markup { \italic \normalsize "Sjunges deklamerande med låtsat allvar." }
{
\time 3/4
\key a \minor
\partial 8

 a'8  | 
 e''8. e''16 d''8 c'' b' c''  | 
 d''16-( c''-) b'-( c''-) a'4. c''8  | 
 b'8. a'16 g'8 fis' e' g'  | 
 b'4 b' r8 b'  | 
 e''8. e''16 d''4. b'8  | 
 d''16-( c''-) b'-( c''-) a'4. c''8  | 
 b'8. a'16 g'8-( fis'-) e' g'  | 
 b'4 b' r8 g'  | 
 fis'8. g'16 a'8 g' fis' g'  | 
 e'8. e'16 e''4. d''8  | 
 c''8. b'16 a'8 c'' b' gis'  | 
 b'4 a'4. \bar "|."
 }
 \addlyrics {
     \set stanza = #"1. "
     Ock kat -- ten la -- de sig från un --  -- gar sju, ock
     hon be -- kla -- ga -- de sitt ö -- de: »Jag är så sjuk, jag
     är så sjuk, jag har så ont __ i mitt hu -- dä!» Ty då var kat -- te -- mi -- sen
     sjuk, ja sjuk, ja då var kat -- te -- mis -- sen sju -- ker.
}
