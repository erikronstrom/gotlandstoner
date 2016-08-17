\override Stem #'stencil = ##f
\override Score.TimeSignature #'stencil = ##f
\partial 4
 < cis'' a' e' a  >4^\markup { \center-align { \italic "Stämning." } }
\revert Stem #'stencil
\revert Score.TimeSignature #'stencil
\bar "||"

\override TextSpanner.bound-details.left.text = "pizz."

\time 3/4
\key a \major

\repeat volta 2 { 
 cis''4-> b'8. d''16 cis''8 a'  | 
 a'\startTextSpan cis'' cis'' a' e' a\stopTextSpan  | 
 a' a'16 cis'' b'8 b'16 d'' cis''8 a'  | 
 cis''16 b' a' gis' b'4 a'  |
 } %( endrepeat )% 
\repeat volta 2 { 
 cis''8.-> e''16 e'' fis'' e'' d'' cis''8. e''16  | 
 e'' fis'' e'' d'' cis''8\startTextSpan a' a' cis''  | 
 < a e'  >8. cis''16 cis''8. cis''16 a'8 cis''  | 
 < a e'  >8. cis''16 cis''8. cis''16 a'8 cis''  | 
 < a e'  >8. cis''16 cis''8. cis''16 a'8 cis''  | 
 < a e'  >8. cis''16 cis''8. cis''16 a'8 cis''\stopTextSpan  | 
 a' a'16 cis'' b'8 b'16 d'' cis''8 a'  | 
 cis''16 b' a' gis' b'4 a'  |
 } %( endrepeat )% 
\repeat volta 2 { 
 fis'16 d' fis' a' fis' d' fis' a' fis' d' fis' a'  | 
 e' cis' e' a' e' cis' e' a' e' cis' e' a'  | 
 fis' d' fis' a' fis' d' fis' a' fis' d' fis' a'  | 
 e' cis' e' a' e' cis' e' a' < a e' a' cis''  >4  | 
 cis''-> b'8 b'16 d'' cis''8 a'  | 
 cis''16 b' a' gis' b'4 a'  |
 } %( endrepeat )% 
 