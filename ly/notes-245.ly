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
 < f f' a' f''  >4 f''16 e'' f'' g'' a''8. f''16  | 
 c''8 d''16 c'' bes'8 d''16 c'' a'8 < f f' a'  >  | 
 < f f' a' f''  >16 a' c'' f'' < f f' a' a''  > c'' f'' a'' c'''8. e''16  | 
 f'' e'' f'' a'' g'' f'' e'' d'' d''8 c''  | 
 < f f' a' f''  >4 f''16 e'' f'' g'' a''8. f''16  | 
 c''8 d''16 c'' bes'8 d''16 c'' a' f' f f'  | 
 f''8 < f f' a'  > a'' < f f' a'  > c''' a''  | 
 g''16 bes'' e'' g'' g''4 f''  |
 } %( endrepeat )% 
\repeat volta 2 { 
 < f' a'  >16 < f f'  > < f f'  > < f' a'  > < f' c''  > < f f'  > < f f'  > < f' c''  > < f' a'  > < f f'  > < f f'  > < f' a'  >  | 
 a'8 g' g'16 f' g' bes' a'8. f'16  | 
 < f' a'  > < f f'  > < f f'  > < f' a'  > < f' c''  > < f f'  > < f f'  > < f' c''  > < f' a'  > < f f'  > < f f'  > < f' a'  >  | 
 a'8 g'  \acciaccatura { a'16 }  g' f' g' a' f'4  |
 } %( endrepeat )% 
\repeat volta 2 { 
 < c'' e''  >16 < bes' c''  > < bes' c''  > < c'' e''  > < c'' e''  > < bes' g'  > < bes' g'  > < c'' e''  > < c'' e''  > < bes' c''  > < bes' c''  > < c'' e''  >  | 
 < a' f''  > < f f' a'  > < f f' a'  > f''  < a' a''  > < f f' a'  > < f f' a'  > a'' < a' f''  > < f f' a'  > < f f' a'  > f''  | 
 < c'' e''  > < bes' c''  > < bes' c''  > < c'' e''  > < c'' e''  > < bes' g'  > < bes' g'  > < c'' e''  > < c'' e''  > < bes' c''  > < bes' c''  > < c'' e''  >  | 
 f''8 e''16 f'' g'' f'' e'' d'' d''8 c''  |
 } %( endrepeat )% 
 < f f' a' f''  >4 f''16 e'' f'' g'' a''8. f''16  | 
 c''8 d''16 c'' bes'8 d''16 c'' < f' a'  > f' f f'  | 
 < f f' a' f''  > a' c'' f'' < f f' a' a''  > c'' f'' a'' c'''8. f''16  | 
 g'' bes'' e'' g'' g''4 f'' \bar "|." |
 