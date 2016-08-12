\time 3/4
\key f \major

\repeat volta 2 { 
 \partial 8
 %\override Script #'padding = 1
 %\override Script #'stencil = #ly:text-interface::print
 %\override Script.text = \markup { \musicglyph #"scripts.umarcato" }
 \override Script #'outside-staff-priority = #1
 c''16 bes'  | 
 a'-^ c'' f'' a'' g'' e'' f'' d'' c'' a' bes' g'  | 
 a'-^ c'' f'' a'' g'' bes'' e'' g'' g''8 f''  | 
 \flatBeams
 a'16-^ f'' c'' f'' a' f'' c'' f'' a' f'' c'' f''  | 
 bes'-^ f'' d'' f'' bes' f'' d'' f'' bes' f'' d'' f''  | 
 a'-^ f'' c'' f'' a' f'' c'' f'' a' f'' c'' f''  | 
 bes'-^ f'' d'' f'' bes' f'' d'' f'' bes' f'' d'' f''  | 
 \normalBeams
 e'' c'' bes'' a'' g'' f'' e'' d'' c'' bes' a' g'  | 
 a' f'' e'' g'' g''4 f''8
 } %( endrepeat )% 
\repeat volta 2 { 
 c'''  | 
 c'''16-^ bes'' a'' bes'' c''' e'' f'' g'' a'' cis'' d'' e''  | 
 f'' a' bes' c'' d'' c'' bes' a' bes'4  | 
 bes''16-^ a'' g'' a'' bes'' e'' f'' g'' f'' e'' d'' e''  | 
 f'' e'' f'' a'' g'' f'' e'' d'' d''8 c''  | 
 a'16-^ c'' f'' c'' f'' a'' c'' f'' f'' a'' c'' f''  | 
 e'' g'' bes'' g'' a'' g'' f'' e'' f''4  | 
 a'16 c'' f'' c'' f'' a'' a' f'' f'' a'' a' f''  | 
 e'' g'' bes'' g'' a'' g'' f'' e'' f''4  | 
 c''16-^ bes'' g'' a'' g'' a'' e'' g'' f'' a' bes' d''  | 
 c'' bes' a' g' g'4 f'8
 } %( endrepeat )% 
 