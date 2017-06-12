\time 3/4
\key a \major

\repeat volta 2 { 
 \once \override TextScript.padding = #3
 a'4^\markup { \italic "Förstämd bas till a." }
 b'16 gis' a' b' cis''8 a'  | 
 e'4 dis'16 e' fis' gis' a'8 a  | 
 a16 cis' e' a' cis'' e'' a'' e'' d'' cis'' b' a'  | 
 d'' e'' d'' cis'' b' cis'' b' a' gis'8 e'  | 
 a'16 gis' a' b' c'' b' c'' d'' e''4  | 
 g''-> g''16 f'' d'' e'' c''4  | 
 c''16 b' c'' d'' e'' c''^\markup { * } b' d'' a' c'' e' gis'  | 
 a'8 e'16 d' cis'! d' b cis' a4  |
 } %( endrepeat )% 
 \key a \minor
 
\repeat volta 2 { 
 c''16 b' g' b' c'' e'' d'' c'' b' f'' d'' b'  | 
 c''8 d''16 e'' f'' g'' a'' b'' c'''4  | 
 c'''16 b'' g'' a'' b'' g'' e'' g'' a''4  | 
 a''16 g'' e'' g'' g'' f'' d'' f'' f'' e'' c'' e''  | 
 e'' d'' b' d'' d'' c'' a' c'' c'' b' g' b'  | 
 a c' e' a' b'8 c'' b'16 c'' e' g'  | 
 a' e' a' c'' e''8 c'' b'16 c'' e' g'  | 
 a'8 e'16 d' c' d' b c' a4  |
 } %( endrepeat )% 
\repeat volta 2 { 
 \key a \major
 a'8 e'16 e' e'8 e' a' cis''  | 
 e''' e''16 e'' e''8 e'' e''16 d''' cis''' b''  | 
 a'' gis'' fis'' e'' dis'' e'' fis'' e'' gis' b' fis'' e''  | 
 cis''8 e'16 fis' e'8 e' e'16 d'' b' gis'  | 
 a' e' dis' e' a e' dis' e' cis'' e' a e'  | 
 b' e' dis' e' b' d'' cis'' b' a' gis' fis' e'  | 
 a' a e' a' cis'' e'' a'' gis'' fis'' e'' d'' cis''  | 
 cis'' d'' fis' gis' a'4 a  |
 } %( endrepeat )% 
\repeat volta 2 { 
 \flatBeams
 \textedMeasureBracket \twice {
     < a e'  >16 cis'' e'' cis'' < a e'  > cis'' e'' cis'' < a e'  > cis'' e'' d''  | 
 }
 < a e'  > cis'' a'' cis'' < a e'  > cis'' a'' cis'' < a e'  > cis'' a'' cis''  | 
 < a ees'  > c'' a'' c'' < a ees'  > c'' a'' c'' < a ees'  > c'' a'' c''  | 
 \normalBeams
 < a e'!  > cis''! a'' fis'' fis'' e'' d'' cis'' gis' d'' fis'' e''  | 
 gis'' e'' fis'' gis'' b''4 a''  |
 } %( endrepeat )% 
 