{
\time 4/4
\key a \minor

 \partial 4
 e'4  | 
 a' c'' b' b'  | 
 a'2 g'4 c''8-( d''-)  | 
 e''4 e'' f''8-( e''-) d''-( c''-)  | 
 b'2. r4  | 
 
\repeat volta 2 { 
 c''2 b'4 gis'  | 
 a' e'' e''2  | 
 b' r4 d''8-( c''-)  |
 \override TextScript.outside-staff-padding = 1.5
 a'4  c''8-(^\markup { \italic "ritardando" } b'-) gis'-( a'-) b'-( c''-)  | 
  } 
\alternative { 
 {  a'2. r4   |
 } %( endrepeat )% 
 
 { % beginalt
 a'2.  }} 
 \bar "|."
 }
 \addlyrics {
     \set stanza = #"1. "
     Den skö -- na A -- dolf Dam -- borg i __ sorg bland pal --  -- mer gick
     allt för sin Al -- ber -- ti -- na, den han ej __ skå --  -- da fick. fick.
}
