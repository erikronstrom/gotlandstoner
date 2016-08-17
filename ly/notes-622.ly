\time 2/4
\key bes \major

\repeat volta 2 { 
 \partial 8
 f''16 ees''  | 
 d''8 f'' d'' f''  | 
 bes'' f'' d'' bes'  | 
 a'16 bes' c'' d'' ees'' d'' ees'' c''  | 
 bes'8 d''16 bes' f'8 f''16 ees''  | 
 d''8 f'' d'' f''  | 
 bes'' f'' d'' bes'  | 
 a'16 bes' c'' d'' ees'' c'' a' c''  | 
 bes'4 r8
 } %( endrepeat )% 
 
\repeat volta 2 { 
 c''16 bes'  | 
 a'8 f'' e''16 f'' g'' e''  | 
 f''8 a''16 f'' c''8 c''16 bes'  | 
 a'8 f'' e''16 f'' g'' e''  | 
 f''4 f''16 ees'' d'' ees''  | 
 d''8 f'' d'' f''  | 
 bes'' f'' d'' bes'  | 
 a'16 bes' c'' d'' ees'' c'' a' c''  | 
 bes'4 r8
 } %( endrepeat )% 
  
\break 
\time 3/8
\override Score.RehearsalMark.padding = #2
\mark \markup { \normalsize "4 ggr" }
\repeat volta 2 { 
 \set Timing.measureLength = #(ly:make-moment 1/8)
 f''16 ees''  | 
 \set Timing.measureLength = #(ly:make-moment 3/8)
 d''8 bes' bes'  | 
 bes'4 bes''16 a''  | 
 a'' g'' fis'' g'' bes'' g''  | 
 f''4 d''8  | 
 ees'' g'' ees''16 c''  | 
 bes' a' g'' f'' ees'' d''  | 
 bes' d'' bes' d'' c'' a'  | 
 bes'4
 } %( endrepeat )% 
 