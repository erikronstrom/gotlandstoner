\time 3/4
\key d \major

\repeat volta 2 { 
 \once \override TextScript.padding = #3
 < a d'  >8-(^\markup { \italic "G-strängen stämmes i A." } fis'-) a'-( d''-) fis''4  | 
 fis''8-( e''-) cis''-( e''-) a'4  | 
 < a e'  >8-( a'-) cis''-( e''-) g''4  | 
 b''8-( a''-) fis''-( d''-) a'-( fis'-)  | 
 < a d'  > fis' a'-( d''-) fis''4  | 
 fis''8-( e''-) cis''-( e''-) a'4  | 
 g''8-( fis''-) g''-( a'-) cis''-( e''-)  | 
  } 
\alternative { 
 {  d''2 r4   |
 } %( endrepeat )% 
 
 { % beginalt
 d''2 d''8 e''  }} 
 
\repeat volta 2 { 
 fis''4 < a d'  > fis''  | 
 fis''8-( e''-) cis''-( b'-) a'4  | 
 g'' < a e'  > g''  | 
 e''8-( d''-) cis''-( b'-) a'4  | 
 < a d' a' fis''  > < a d' a' fis''  > < a d' a' fis''  >  | 
 fis''8-( e''-) cis''-( e''-) a''4  | 
 a''8-( fis''-) g''-( a'-) cis''-( e''-)  | 
  } 
\alternative { 
 {  d''2 d''8 e''   |
 } %( endrepeat )% 
 
 { % beginalt
 d''2. \bar "|." }} 
 
 