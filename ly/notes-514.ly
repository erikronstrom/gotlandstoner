\time 3/4
\key c \major

\repeat volta 2 { 
 \partial 4
 g'4  | 
 e'' e''8 e'' e'' e''  | 
 f''4 a'' g''  | 
 e''2 d''8-( c''-)  | 
 b'2 b'8 b'  | 
 b'4 d'' c''  | 
 b'2 b'8 b'  | 
 b'4 g'' a''  | 
 b''4. a''8 g'' f''  | 
 e''4 e''8 e'' e'' e''  | 
 f''4 a'' g''  | 
 e''2 d''8-( c''-)  | 
 b'2 b'8 b'  | 
 b'-( d''-) e''-( d''-) c''-( a'-)  | 
 g'-( b'-) c''-( b'-) a'-( g'-)  | 
 e'-( b'-) c''-( b'-) a'-( f'-)  | 
  } 
\alternative { 
 {  \set Timing.measureLength = #(ly:make-moment 1/2)
    e'2
 } %( endrepeat )% 
 
 { % beginalt
 \set Timing.measureLength = #(ly:make-moment 3/4)
 e' b'8 b'  }} 
 
\repeat volta 2 { 
 b'2 b''4  | 
 b'2 b''4  | 
  \times 2/3 { b'8 c'' b' }  a'4 b'  | 
 d''2 c''4  | 
 b'2 b''4  | 
 b'2 b''4  | 
 b'8\trill b' a'4 b'  | 
 d''2 c''4  | 
 b'2 b''4  | 
 b'2 b''4  | 
 d''\trill cis'' d''  | 
 f''2 e''4  | 
 d''2 d'''4  | 
 c'''2 e''4  | 
 d''2 c''4  | 
  } 
\alternative { 
 {  b'2 b'8 b'   |
 } %( endrepeat )% 
 
 { % beginalt
 b'2 b'8 d''  }} 
 
\repeat volta 2 { 
 c''-( e''-) f'-( e'-) f'4  | 
 b'8-( d''-) f'-( e'-) f'4  | 
 a'8-( c''-) d'-( cis'-) d'4  | 
 d'8-( g'-) g'-( b'-) b'-( d''-)  | 
 d''-( f''-) f''-( e''-) f'4-~  | 
 f' f'8-(-> a'-) a'-( c''-)  | 
 c''-( e''-) e''-( d''-) g'4-~  | 
 g'-> g'8-( b'-) b'-( d''-)  | 
 c''-( e''-) f'-( e'-) f'4  | 
 b'8-( d''-) f'-( e'-) f'4  | 
 a'8-( c''-) d'-( cis'-) d'4  | 
 d'8-( e'-) e'-( g'-) g'-( b'-)  | 
 b'-( d''-) d''-( f''-) f''-( g''-)  | 
 g''-( a''-) a''-( b''-) b''-( a''-)  | 
 a'' a'' b''4 g''  | 
  } 
\alternative { 
 {  d'' r b'8 d''   |
 } %( endrepeat )% 
 
 { % beginalt
 d''4 r d''8 c''  }} 
 
\repeat volta 2 { 
 b'4 b'4. c''8  | 
 d''4 d''4. g''8  | 
 e''4 e''4. g''8  | 
 d''2.  | 
 d'''4 e'''4. d'''8  | 
 c'''2.-~  | 
 c'''4 a'4. c''8  | 
 b'2 d''8 c''  | 
 b'4 b'4. c''8  | 
 d''4 d''4. g''8  | 
 e''4 e''4. g''8  | 
 d''2.  | 
 b'4 e''4. d''8  | 
 c''2.  | 
 c''4 b'4. a'8  | 
 a'2.  | 
  } 
\alternative { 
 {  g'4 r d''8 c''   |
 } %( endrepeat )% 
 
 { % beginalt
 g'2 \bar "|." }} 
 
 