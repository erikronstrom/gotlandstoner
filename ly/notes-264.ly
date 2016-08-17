\override Stem #'stencil = ##f
\override Score.TimeSignature #'stencil = ##f
\partial 4
 < a e' a' e''  >4^\markup { \center-align { \italic "Stämning." } }
\revert Stem #'stencil
\revert Score.TimeSignature #'stencil
\bar "||"

\time 3/4
\key a \major

\repeat volta 2 { 
 e''8 e'' cis''16 a' b' cis'' << e''4 \\ { cis''8 d'' } >>   | 
 fis''8 e'' gis''16 e'' fis'' gis'' gis''8 a''  | 
 a''16 fis'' d'' fis'' fis'' e'' cis'' e'' e'' d'' b' d''  | 
 cis'' d'' cis'' b' a' b' cis'' a' < a e'  >4  | 
 e''8 e'' cis''16 a' b' cis'' << e''4 \\ { cis''8 d'' } >>  | 
 fis'' e'' gis''16 e'' fis'' gis'' gis''8 a''  | 
 a''16 fis'' d'' fis'' fis'' e'' cis'' e'' e'' d'' b' d''  | 
 cis'' a' b' gis' a'4 < a e'  >  |
 } %( endrepeat )% 
\repeat volta 2 { 
 a'16 b' cis'' d'' cis''8 < a e' cis''  > < a e' cis''  > < a e' cis''  >  | 
 < a e'  > a'16 b' cis''8 b'16 cis'' d'' cis'' b' cis''  | 
 a' b' cis'' d'' < a e' cis'' e''  >8 < a e' cis'' e''  > < a e' cis'' e''  > < a e' cis'' e''  >  | 
 < a e'  >16 a' b' cis'' d'' cis'' d'' fis'' e'' d'' cis'' b'  | 
 e''8 e'' cis''16 a' b' cis'' << e''4 \\ { cis''8 d'' } >>  | 
 fis'' e'' gis''16 e'' fis'' gis'' gis''8 a''  | 
 a''16 fis'' d'' fis'' fis'' e'' cis'' e'' e'' d'' b' d''  | 
 cis'' a' b' gis' a'4 < a e'  >  |
 } %( endrepeat )% 
\repeat volta 2 { 
 < a e'  >16 a' cis'' a' gis' a' cis'' e'' e'' d'' b' a'  | 
 gis' b' d'' b' gis' b' d'' e'' e'' d'' cis'' b'  | 
 e' a' cis'' a' gis' a' cis'' e'' e'' d'' b' a'  | 
 gis' b' d'' b' gis' b' d'' e'' e'' d'' cis'' b'  | 
 e''8 e'' cis''16 a' b' cis'' << e''4 \\ { cis''8 d'' } >>  | 
 fis'' e'' gis''16 e'' fis'' gis'' gis''8 a''  | 
 a''16 fis'' d'' fis'' fis'' e'' cis'' e'' e'' d'' b' d''  | 
 cis'' a' b' gis' a'4 < a e'  >  |
 } %( endrepeat )% 
 