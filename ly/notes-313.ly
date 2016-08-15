\override Stem #'stencil = ##f
\override Score.TimeSignature #'stencil = ##f
\partial 4
 < f f' a' e''  >4^\markup { \center-align { \italic "Stämning." } }
\revert Stem #'stencil
\revert Score.TimeSignature #'stencil
\bar "||"

\time 3/4
\key f \major

\repeat volta 2 { 
 \set Timing.measureLength = #(ly:make-moment 1/8)
 a'8  | 
 \set Timing.measureLength = #(ly:make-moment 3/4)
 < f f'  >8. a''16 a''8. f''16 g'' f'' e'' f''  | 
 < f f'  >8. d''16 d''8. c''16 c''8 bes'  | 
 a'16 bes' c'' d'' c''8 d''16 e'' f''8 g''16 a''  | 
 bes''8 g'' a''16 g'' f'' e'' f''8 c''16 a'  | 
 < f f'  >8. a''16 a''8. f''16 g'' f'' e'' f''  | 
 f'8. d''16 d''8 c'' c'' bes'  | 
 a'16 bes' c'' d'' c''8 d''16 e'' f''8 g''16 a''  | 
 bes''8 g'' a''16 g'' f'' e'' f''8
 } %( endrepeat )% 
 
\repeat volta 2 { 
 a'  | 
 a'16-( f' f-) f' a'-( f' f-) f' d''-> c'' bes' a'  | 
 bes'-( f' f-) f' bes'-( f' f-) f' ees''-> d'' c'' bes'  | 
 a'-( f' f-) f' a'-( f' f-) f' d''-> c'' bes' a'  | 
 bes'-( f' f-) f' bes'-( f' f-) f' ees''-> d'' c'' bes'  | 
 a' bes' c'' d'' c''8 d''16 e'' f''8 g''16 a''  | 
 bes''8 g'' a''16 g'' f'' e'' f''8
 } %( endrepeat )% 
 