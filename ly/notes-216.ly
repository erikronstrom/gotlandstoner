\override Stem #'stencil = ##f
\override Score.TimeSignature #'stencil = ##f
\partial 4
 < e'' a' d' d  >4^\markup { \center-align { \italic "Stämning." } }
\revert Stem #'stencil
\revert Score.TimeSignature #'stencil
\bar "||"

\time 3/4
\key d \major

\repeat volta 2 { 
 < d fis'  >4 < d e'  > < d d'  >  | 
 < fis a'  >8 < fis a'  > < e g'  > < e g'  > < d fis'  >8. a'16  | 
 d''8 d''16 fis'' e''8 e''16 g'' g''8 a''  | 
 a''16 g'' e'' g'' g'' fis'' g'' e'' d'' cis'' b' a'  | 
 fis' d fis' a' e' d e' a' d' d fis' a'  | 
 fis' d fis' a' e' d e' a' fis'8 a'  | 
 d''16 a' d'' fis'' e'' a' e'' g'' fis'' d'' fis'' a''  | 
 b'' g'' e'' cis'' d''4 d'8 r  |
 } %( endrepeat )% 
\repeat volta 2 { 
 e''16 d'' cis'' b' a' cis'' e'' cis'' a'8. g'16  | 
 fis' d' e' fis' g' a' b' cis'' d''8 fis''  | 
 e''16 d'' cis'' b' a' cis'' e'' cis'' a'8. g'16  | 
 fis' d' e' fis' g' a' b' cis'' d''4  | 
 < fis fis'  >8 a' < e e'  > a' < d d'  > fis''  | 
 e''16 d'' cis'' b' a' cis'' e'' fis'' g''4  | 
 g'8 b'' fis' a'' e' g''  | 
 fis''16 e'' d'' cis'' d''4 d'  |
 } %( endrepeat )% 
\repeat volta 2 { 
 e''16 a' fis' a' d'' a' fis' a' d'' a' fis' a'  | 
 < g a'  >8 < e g'  >16 < e g'  > < e g'  >8 < e g'  > < e g'  >4  | 
 cis''16 a' g' a' cis'' a' g' a' cis'' a' g' a'  | 
 < e g'  >8 < d fis'  >16 < d fis'  > < d fis'  >8 < d fis'  > < d fis'  >4  | 
 d''8 d''16 fis'' e''8 e''16 g'' fis''8 fis''16 a''  | 
 a'' g'' e'' cis'' d''4 d'  |
 } %( endrepeat )% 
 