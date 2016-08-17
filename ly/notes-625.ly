\time 2/4
\key f \major

\repeat volta 2 { 
 \partial 8
 c''16 bes'  | 
 a'8 c'' f'' c''16 bes'  | 
 a'8 c'' a''8. f''16  | 
 e''8 g'' bes''8. g''16  | 
 f'' a'' g'' f'' e'' d'' c'' bes'  | 
 a'8 c'' f'' c''16 bes'  | 
 a'8 c'' a''8. f''16  | 
 e''8 g'' g''16 bes'' g'' e''  | 
 f''8 a'' f''
 } %( endrepeat )% 
 
\repeat volta 2 { 
 c''  | 
 f''16 g'' a'' g'' f'' e'' d'' c''  | 
 c'' bes' d'' c'' bes' a' g' f'  | 
 e' f' g' a' bes' c'' d'' e''  | 
 f'' e'' g'' f'' e'' d'' c'' c''  | 
 a'8 c'' f'' c''16 bes'  | 
 a'8 c'' a''8. f''16  | 
 e''8 g'' g''16 bes'' g'' e''  | 
 f''8 a'' f''
 } %( endrepeat )% 
 
\repeat volta 2 { 
 f''16 g''  | 
 a''8 c'' g'' c''  | 
 f'' e''16 d'' c''8 c''  | 
 bes'' d'' a'' b'  | 
 g''16 f'' e'' d'' c''4  | 
 a''8 c'' g'' c''  | 
 f'' f''16 g'' f''8 e''  | 
 d'' bes''16 a'' g'' f'' e'' f''  | 
  } 
\alternative { 
 {  \set Timing.measureLength = #(ly:make-moment 3/8)
 g''4 f''8   |
 } %( endrepeat )% 
 
 { % beginalt
 \set Timing.measureLength = #(ly:make-moment 2/4)
 g''4 f''8 c''16 a'  }} 
  | 
 
\repeat volta 2 { 
 f'8 a'16 c'' f'' c'' a' c''  | 
 g'8 bes'16 d'' g'' f'' e'' d''  | 
 c'' d'' e'' f'' g'' bes'' a'' g''  | 
 f''4 e''  | 
 a''8 c'' g'' c''  | 
 f'' f''16 g'' f''8 e''  | 
 d'' bes''16 a'' g'' f'' e'' f''  | 
 g''4 f''  |
 } %( endrepeat )% 
 