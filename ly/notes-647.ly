\time 2/4
\key f \major

\repeat volta 2 { 
 \partial 8
 c''8  | 
 f'' f''16 a'' e''8 e''16 g''  | 
 f''8 f''16 a'' e''8 e''16 g''  | 
 f''8 f'' g'' a''  | 
 bes''8. g''16 f'' e'' d'' c''  | 
 f''8 f''16 e'' f''8 e''  | 
 d'' d''16 c'' d''8 c''  | 
 bes' a' g' f'  | 
 < g e' c''  >4 r8
 } %( endrepeat )% 
 
\repeat volta 2 { 
 c''  | 
 c''8. bes'16 c'' d'' e'' f''  | 
 g''8 g'' e'' c''  | 
 c'' d''16 c'' bes'8 a'  | 
 a'4 g'  | 
 f'8 f'16 e' f'8 a'  | 
 c'' f'' a''4  | 
 g''16 a'' bes'' g'' e'' f'' g'' e''  | 
 f''8 a'' f''
 } %( endrepeat )% 
\repeat volta 2 { 
  
\time 3/8 
 \set Timing.measureLength = #(ly:make-moment 1/8)
 c''  | 
 \set Timing.measureLength = #(ly:make-moment 3/8)
 a'' g''16 f'' e'' d''  | 
 d''8 c'' c''  | 
 c'' bes' bes'  | 
 bes'4 d''8  | 
 bes''16 g'' e'' c'' b' c''  | 
 a' c'' d'' e'' f'' g''  | 
 a''8 bes'' g''  | 
 f''4
 } %( endrepeat )% 
 