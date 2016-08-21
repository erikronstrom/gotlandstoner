{
\time 2/4
\key f \major

\repeat volta 2 { 
 f'8. f'16 a'8 a'  | 
 g'8. g'16 bes'8 bes'  | 
 e'8. f'16 g'8. a'16  | 
 f'4-\fermata f'8. f'16  | 
 g'8-( a'-) bes'8. bes'16  | 
 b'8-( c''-) d''8. e''16  | 
  } 
\alternative { 
 {  c''4.  r8   |
 } %( endrepeat )% 
 
 { % beginalt
 c''4 r8  }} 
 
\repeat volta 2 { 
 bes'  | 
 a'-( c''-) d''8.-> c''16  | 
 d''8-. c''-. g'-. f'-.  | 
 a'8. g'16 fis'8 g'  | 
 f''4-\fermata e''8-( d''-)  | 
 c''8. cis''16 d''8  \acciaccatura { cis'' }  bes'  | 
 a'4  \acciaccatura { g'8 a' bes' c'' }  bes' e'  | 
  } 
\alternative { 
 {  \set Timing.measureLength = #(ly:make-moment 3/8)
 f'4 r8   |
 } %( endrepeat )% 
 
 { % beginalt
 \set Timing.measureLength = #(ly:make-moment 1/2)
 f'2  }} 
 \bar "|." |
 }
 \addlyrics {
     \set stanza = #"1. "
     »Flic -- ka lil -- la, säg mig vad du ha -- ver i ditt sinn? El -- ler
     vad __ du i tan --  -- kar -- na bär? bär? Har du __ nå -- gon an -- nan, som är
     kä -- ra -- re än mig, så __ vill jag va -- ra långt i -- från dig.» dig.»
}
