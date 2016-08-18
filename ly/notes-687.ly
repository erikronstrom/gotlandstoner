\time 4/4
\key f \major

\repeat volta 2 { 
 \partial 4
 f'16-( g' a' bes'-)  | 
 a'8. c''16 c''8 c'' c''4 d''8 e''  | 
 f''4 g''8 a'' f''4 c''8 d''  | 
 bes'4 d''8 f'' a' c'' d''16-( c'' bes' a'-)  | 
 bes'4 g'8 g' f'4 a'8 c''  | 
 bes'4 d''8 f'' a' c'' d''16-( c'' bes' a'-)  | 
 bes'4 g'8. a'16 f'4 a'16-( c'' d'' e''-)  | 
 f''4 f''8. f''16 g''4 g''8 a''  | 
 bes''4 bes''8. bes''16 a''8 g'' a'' g''  | 
 f'' e'' f'' a'' c''4  \times 2/3 { c''8 d'' e'' }   | 
  } 
\alternative { 
 {  \set Timing.measureLength = #(ly:make-moment 3/4)
 f''4 f''8. f''16 f''4
 } %( endrepeat )% 
 
 { % beginalt
 \set Timing.measureLength = #(ly:make-moment 4/4)
 f'' f''8. f''16 f''4 f''8 g''  }} 
 
\repeat volta 2 { 
 f''8. a''16 a''8 a'' bes'' a'' g'' f''  | 
 e''8. f''16 g''8 a'' g''4 g''16-( f'' e'' f''-)  | 
 d''4 d''8 d'' d'' e''16 f'' g''-( f'' e'' d''-)  | 
 c''8 bes' a' g' f'4 a'8 c''  | 
 bes'4-> d''8 f'' a' c'' d''16-( c'' bes' a'-)  | 
 bes'4 g'8 g' f'4 a'8 c''  | 
 bes'4-> d''8 f'' a' c'' d''16-( c'' bes' a'-)  | 
 bes'4 g'8. g'16 f'4 r  |
 } %( endrepeat )% 
\repeat volta 2 { 
  < d'' f''  >-> < d'' f''  >8. < d'' f''  >16 < d'' f''  >4 e''16-( f'' g'' e''-)  | 
  < c'' e''  >4-> < c'' e''  >8 < c'' e''  > < c'' e''  >4 e''16-( f'' g'' e''-)  | 
 bes'4-> bes'8. bes'16 bes'8 d'' c'' bes'  | 
 a' g' f' e' f'4 a'8 c''  | 
 bes'4-> d''8 f'' a' c'' d''16-( c'' bes' a'-)  | 
 bes'4 g'8. g'16 f'4 a'16 c'' d'' e''  | 
 f''4-> f''8. f''16 g''4-> g''8 a''  | 
 bes''4-^ bes''8. bes''16 a''8 g'' a'' g''  | 
 f'' e'' f'' a'' c''4  \times 2/3 { c''8 d'' e'' }   | 
  } 
\alternative { 
 {  f''4 < f' a' f''  >8. f''16 < f' a' f''  >4 r   |
 } %( endrepeat )% 
 
 { % beginalt
 f'' < f' a' f''  >8. f''16 < f' a' f''  >4  }} 
 \bar "|."
 