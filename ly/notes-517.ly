\time 3/4
\key c \major

\repeat volta 2 { 
 g'4 c''8 c'' c'' c''  | 
 c''4 e'' g''  | 
  \grace { f''8 }  a''4 d''8 d'' d'' d''  | 
 d''4 f'' a''  | 
  \grace { e''8 }  g''4 c''8 c'' c'' c''  | 
 c''4. e''8 d'' c''  | 
 b'4 g'8 g' g' g'  | 
 g'2 g'4  | 
 g' c''8 c'' c'' c''  | 
 c''4 e'' g''  | 
  \grace { f''8 }  a''4 d''8 d'' d'' d''  | 
 d''4 f'' a''  | 
  \grace { e''8 }  g''-( a''-) g''-( fis''-) g''-( a''-)  | 
 g''4 b' d''  | 
  \grace { e''8 }  d''4 c''8 c'' c'' c''  | 
 c''2 r4  |
 } %( endrepeat )% 
 
\repeat volta 2 { 
 b'2 c''4  | 
 d'' e'' f''  | 
  \grace { f''8 }  a''2.  | 
 g''  | 
 b'2 c''4  | 
 d'' e'' f''  | 
 a''2 b''8-( a''-)  | 
 g''4. a''8-( g'' f''-)  | 
 e'' g'' c'' c'' c'' c''  | 
 c''4 e'' g''  | 
 f''8 a'' d'' d'' d'' d''  | 
 d''4 f'' a''  | 
 g''8-( a''-) g''-( fis''-) g''-( a''-)  | 
 g''4 b' d''  | 
 d'' c''8 c'' c'' c''  | 
  } 
\alternative { 
 {  c''2 r4   |
 } %( endrepeat )% 
 
 { % beginalt
 c''2  }} 
 
\repeat volta 2 { 
 c''8-( e''-)  | 
 g''4 e'' f''  | 
 d''2 d''8 e''  | 
 f''4 e'' g''  | 
 c''2 e''4  | 
 e'' d'' f''  | 
 b'2 d''4  | 
 c'' c''8-( d''-) e''-( f''-)  | 
 g''2 c''8-( e''-)  | 
 g''4 e'' f''  | 
 d''2 d''8-( e''-)  | 
 f''4 e'' g''  | 
 c''2 e''4  | 
 d''8-( e''-) d''-( c''-) d''-( e''-)  | 
 f''4 g' b'8-( d''-)  | 
 d''4 c'' c''  | 
  } 
\alternative { 
 {   
 \set Timing.measureLength = #(ly:make-moment 2/4)
 c''2   |
 } %( endrepeat )% 
 
 { % beginalt
 \set Timing.measureLength = #(ly:make-moment 3/4)
 c''2.  }} 
 \bar "|." |
 