{
\time 3/4
\key d \major
\partial 4

\repeat volta 2 { 
 a'4  | 
 d'' d''8 d'' fis'' d''  | 
 a'4 a' b'8 b'  | 
 g'4 g' a'  | 
  } 
\alternative { 
 {  fis'2   |
 } %( endrepeat )% 
 
 { % beginalt
 fis'  }} 
 \bar "||"
 fis'8 g'  | 
 b'4 a' fis'8 g'  | 
 b'4 a' a'  | 
 d'' d'' e''8 fis''  | 
 g''2 fis''8 e''  | 
 e''4 d'' fis'8 g'  | 
 b'4 a' r8 gis'  | 
 a'4 g'' e''8 cis''  | 
 d''2 \bar "|." |
 }
 \addlyrics {
     \set stanza = #"1. "
     »Nu kom -- mer den förs -- ta fri -- arn, mam -- ma lil -- la, just nu!
     \once \override LyricText.self-alignment-X = #-0.8 "nu!» —"
     »Myc -- ket pän -- gar har han på sig, min dot -- ter Ju -- li -- 
     a, myc -- ket pän -- gar har han på sig, min dot -- ter Ju -- li -- a?»
}
