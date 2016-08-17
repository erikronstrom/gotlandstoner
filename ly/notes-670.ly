\time 2/4
\key g \major

\repeat volta 2 { 
 \partial 8
 d''8  | 
 d''16 c'' b' c'' d''8 g''  | 
 e''16 d'' c'' d'' e''8 a''  | 
 g''16 fis'' e'' fis'' d''8 e''16 fis''  | 
  } 
\alternative { 
 {  \set Timing.measureLength = #(ly:make-moment 3/8)
 g''8 b'' d''   |
 } %( endrepeat )% 
 
 { % beginalt
 \set Timing.measureLength = #(ly:make-moment 2/4)
 g'' b'' g''  }} 
 
\repeat volta 2 { 
 d''  | 
 c''16 d'' b' c'' a' c'' b' d''  | 
 c''8 a''16 gis'' a''8 a'16 c''  | 
 b' c'' a' c'' b' d'' fis' a'  | 
 g'8 g'' g'
 } %( endrepeat )% 
 