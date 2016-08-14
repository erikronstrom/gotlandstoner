\time 3/4
\key c \major

\repeat volta 2 { 
 \partial 4
 g'4  | 
 c''8 g' c'' e'' d'' b'  | 
 d'' c'' c'' e'' f'' a''  | 
 a'' g'' g'' g' b' d''  | 
 f'' e'' e'' g' e' g'  | 
 c'' g' c'' e'' d'' b'  | 
 d'' c'' c'' e'' f'' a''  | 
 a'' g'' g'' g' b' d''  | 
 c''2
 } %( endrepeat )% 
 \key g \major
 
\repeat volta 2 { 
 c''8 e''  | 
 e'' d'' d'' c'' a' c''  | 
 c'' b' b' d'' g'' b''  | 
 b'' a'' a'' d'' fis'' a''  | 
 a'' g'' g'' g' b' d''  | 
 d'' c'' c'' a' a' c''  | 
 c'' b' b' d'' g'' b''  | 
 b'' a'' a'' d'' fis'' a''  | 
 g''2
 } %( endrepeat )% 
 \key c \major
 g''8 f'' 
\repeat volta 2 { 
 e''4. f''8 g'' e''  | 
 c''4. e''8 g'' e''  | 
 c'''4 a'' a''8 bes''  | 
 a''4. g''8 f'' e''  | 
 e''4 d'' d''  | 
  } 
\alternative { 
 {  g''2 a''8 g''  | 
 f'' e'' d'' e'' f'' g''  | 
 e''2 g''8 f''
 }
 { % beginalt
 b'4. g'8 a' b'
 c'' b' c'' e'' d'' b'  | 
 \set Timing.measureLength = #(ly:make-moment 1/2)
 c''2 \bar "|." }
 } %( endrepeat )% 
 