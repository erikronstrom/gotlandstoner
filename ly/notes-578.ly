\time 2/4
\key g \major

\repeat volta 2 { 
 \partial 8
 b'16 c''  | 
 d''8 d''16 e'' d''8 d''16 e''  | 
 d''8 b' b'4->  | 
 a'8 a'16 b' c''8 c''16 d''  | 
 e''8 d'' d'' b'16 c''  | 
 d''8 d''16 e'' d''8 d''16 e''  | 
 d''8 b' b'4->  | 
 a'8. b'16 c'' d'' e'' fis''  | 
  } 
\alternative { 
 {  \set Timing.measureLength = #(ly:make-moment 3/8)
    g''8 g'' g''
 } %( endrepeat )% 
 
 { % beginalt
 \set Timing.measureLength = #(ly:make-moment 1/2)
 g'' g'' g''4  }} 
 
\repeat volta 2 { 
 a' b'16 cis'' d'' e''  | 
 fis''4. e''16 fis''  | 
 g''8 e'' e'' d''16 e''  | 
 fis''8 d'' d'' r  | 
 a'4-> b'16 cis'' d'' e''  | 
 fis''4. e''16 fis''  | 
 g''8 r cis'' r  | 
 b'4-> c''8-> b'16 c''  | 
 d''8 d''16 e'' d''8 d''16 e''  | 
 d''8 b' b'4->  | 
 a'8 a'16 b' c''8 c''16 d''  | 
 e''8 d'' d'' b'16 c''  | 
 d''8 d''16 e'' d''8 d''16 e''  | 
 d''8 b' b'4->  | 
 a'8. b'16 c'' d'' e'' fis''  | 
 g''8 g'' g'' r  |
 } %( endrepeat )% 
\repeat volta 2 { 
 \key c \major
  | 
 g''4. e''16 c''  | 
 g'4.-> b'16 c''  | 
 d''8 c'' b' c''  | 
 e''4-> d''->  | 
 g'-~ g'16 b' d'' g''  | 
 b''4. a''8  | 
 g''-! fis''-! g''-! a''-!  | 
 g'' f'' e'' f''  | 
  \grace { e'' }  g''4. e''16 c''  | 
 g'4. b'16 c''  | 
 e''8 c'' b' c''  | 
 e''4-> d''->  | 
 g'-~ g'16 b' d'' g''  | 
 b''4. a''8  | 
 g''-! f''-! e''-! d''-!  | 
 c'' c''16 c'' c''8 r  |
 } %( endrepeat )% 
 