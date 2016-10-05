\time 3/4
\key g \major

\repeat volta 2 { 
 < g d' d''  >8. g''16 g'' fis'' g'' e'' d''4  | 
 c''16 b' a' g' fis' g' a' b' c''4  | 
 c''8 e''16 c'' b'8 d''16 b' a'8 c''16 a'  | 
 g' fis' g' b' a' g' fis' e' d'4  | 
 < g d' d''  >8. g''16 g'' fis'' g'' e'' d''4  | 
 c''16 b' a' g' fis' g' a' b' c''4  | 
 c''8 e''16 c'' b'8 d''16 b' a'8. c''16  | 
 b' a' g' fis' fis'4 g'  |
 } %( endrepeat )% 
 
\repeat volta 2 { 
 << { \stemUp d''\smallFlageolet g''\smallFlageolet b''\smallFlageolet \stemNeutral } \\
    { \harmonicsOn \override Stem #'transparent = ##t
      d' c' b
      \harmonicsOff \revert Stem #'transparent } >> | 
 d''8 d''16 e'' d'' c'' a' c'' c''8 b'  | 
 d''4\smallFlageolet g''\smallFlageolet b''\smallFlageolet  | 
 d''8 d''16 e'' d'' c'' a' c'' b'4  | 
 d''16 g'' fis'' g'' d'' e'' d'' c'' c'' b' a' g'  | 
 b' g' a' fis' g'4 g  |
 } %( endrepeat )% 
\repeat volta 2 { 
 b'8. a'16 g' fis' e' d' e'8 c''  | 
 b' a'16 g' a' g' fis' e' d'4  | 
 b'8. a'16 g' fis' e' d' e'8 c''  | 
 b' a'16 g' fis' g' e' fis' d'4  | 
 d''\smallFlageolet g''\smallFlageolet b''\smallFlageolet  | 
 d''8 d''16 e'' d'' c'' a' c'' c''8 b'  | 
 d''4\smallFlageolet g''\smallFlageolet b''\smallFlageolet  | 
 d''8 d''16 e'' d'' c'' a' c'' b'4  | 
 d''16 g'' fis'' g'' d'' e'' d'' c'' c'' b' a' g'  | 
 b' g' a' fis' g'4 g  |
 } %( endrepeat )% 
 