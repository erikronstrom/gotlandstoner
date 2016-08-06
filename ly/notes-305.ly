\override Stem #'stencil = ##f
\override Score.TimeSignature #'stencil = ##f
\partial 4
 < e'' a' f' f  >4^\markup { \center-align { \italic "Stämning." } }
\revert Stem #'stencil
\revert Score.TimeSignature #'stencil
\bar "||"

\time 3/4
\key f \major

\repeat volta 2 { 
 a'16 bes'  | 
 c''8 c''16 d'' bes'8 bes'16 c'' a'8 a'16 bes'  | 
 c''8 c''16 d'' bes'8 bes'16 c'' a'8. c''16  | 
 f'' e'' f'' g'' a''8 a''16 g'' bes''8 bes''16 a''  | 
 g'' f'' e'' g'' f''8 c'' < f' a'  > < f' f  >  | 
  < f f' c''  >4->  < f f' bes'  >-> < f' a'  >8-> a'16 bes'  | 
 c''8 c''16 d'' bes'8 bes'16 c'' a'8 c''  | 
 f''16 e'' f'' g'' a''8 a''16 g'' bes''8 bes''16 a''  | 
 g'' f'' e'' g'' f''4 < f f' a' f''  >8  |
 } %( endrepeat )% 
 
\repeat volta 2 { 
 c''  | 
 < f f' a' f''  > f''16 g'' a''8 a''16 f'' d''8 e''16 f''  | 
 g''8 a''16 g'' f'' e'' f'' d'' d''8 c''  | 
 f''16 e'' f'' g'' a''8 a''16 f'' d''8 e''16 f''  | 
 g''8 a''16 g'' f'' e'' f'' d'' c''8 a'16 bes'  | 
  < f f' c''  >4->  < f f' bes'  >->  < f f' a'  >8-> a'16 bes'  | 
 c''8 c''16 d'' bes'8 bes'16 c'' a'8 c''  | 
 f''16 e'' f'' g'' a''8 a''16 g'' bes''8 bes''16 a''  | 
 g'' f'' e'' g'' f''4 < f f' a' f''  >8  |
 } %( endrepeat )% 
 