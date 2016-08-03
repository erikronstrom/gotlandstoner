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
 c''4 c''16 a' bes' d'' d''8 c''  | 
 c''16 a'' e'' g'' f'' a' bes' d'' b'8 c''  | 
 a'16 c'' f'' a'' c''' bes'' a'' bes'' bes'' a'' gis'' a''  | 
 a'' g'' fis'' g'' g'' f'' e'' f'' f'' e'' d'' c''  | 
 c''8 f''4 e''16 d'' d''8 c''  | 
 bes' bes''4 a''16 g'' f'' e'' d'' c''  | 
 f'' a' c'' f'' a'' c'' f'' a'' c'''4  | 
 d'''16 bes'' g'' e'' c'' bes' e'' g'' f''4  |
 } %( endrepeat )% 
\repeat volta 2 { 
 f'16 a' c'' f'' a''4 a''16 bes'' g'' e''  | 
 f'' a'' c''' f''' e''' d''' bes'' g'' f''4  | 
 f''16 a'' c''' f''' c'' e'' g'' c''' a' c'' f'' a''  | 
 f''8 e''16 f'' d''8 bes'4 f''8  | 
 f'' e''16 f'' b'4 c''8 d''16 ees''  | 
 c'''-( ees'' f' f-) f-( f' ees'' b''-) c'''-( ees'' f' f-)  | 
 f-( f' d'' bes''-) a''-( c'' f' f-) f-( f' bes' f''-)  | 
 f''-( a' f' f-) f-( f' c'' a''-) f''4  |
 } %( endrepeat )% 
 