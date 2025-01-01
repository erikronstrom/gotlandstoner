\time 3/4
\key g \major

\repeat volta 2 { 
<< { d''2.\smallFlageolet g''\smallFlageolet b''\smallFlageolet } \\
   { \harmonicsOn \override Stem #'transparent = ##t
     \override Dots.dot-count = #0
     d' c' b
     \harmonicsOff \revert Stem #'transparent
     \revert Dots.dot-count } >>

 r4 r r  | 

<< { d''2.\smallFlageolet g''\smallFlageolet b''\smallFlageolet } \\
   { \harmonicsOn \override Stem #'transparent = ##t
      \override Dots.dot-count = #0
      d' c' b
      \harmonicsOff \revert Stem #'transparent
      \revert Dots.dot-count } >>

 r4 r r  | 
 d''2.  | 
 a'2 b'8 a'  | \break
 g'2.  | 
 r4 r r  | 
 d''2.  | 
 a'2 b'8 a'  | 
 g'2.  | 
 r4 r r  | 
 e''2 c''8 d''  | 
 g''2 fis''8 e''  | 
 d''2 e''8 d''  | 
 b'2 g'4  | 
 e''2 c''8 e''  | 
 g'' fis'' a'' g'' fis'' e''  | 
 e''4 d'' d''  | 
 d''2 c''8 b'  | 
 b'4 a' a'  | 
 a' b' c''  | 
 e''2 d''8 cis''  | 
 d''2 c''8 b'  | 
 b'4 a' a'  | 
 a' b' c''  | 
 e''2 d''8 cis''  | 
 d''4 r d''8 g''  | 
 e''4. c''8 d'' g''  | 
 fis''4. d''8 fis'' a''  | 
 g''2 g''4  | 
 a''8 g'' fis'' e'' d'' c''  | 
 b'4. a'8 b' c''  | 
 d''4 c'' a'  | 
 g' r b'8 a'  | 
  } 
\alternative { 
 {  g'2 r4   |
 } %( endrepeat )% 
 
 { % beginalt
 g'2  }} 
 
\repeat volta 2 { 
 d''4  | 
 a'4. c''8 b' a'  | 
 g'4 d' d''  | 
 a'4. c''8 b' a'  | 
 g'4 d' g''  | 
 b'2 d''4  | 
 g'2 b'4  | 
 a'8. b'16 a'8. g'16 a'8. b'16  | 
 g'2
 } %( endrepeat )% 
\repeat volta 2 { 
 d'4  | 
 g' g'8 g' g' g'  | 
 g'2 g'4  | 
 b' b'8 b' b' b'  | 
 b'2 d''4  | 
 d'' cis'' cis''  | 
 cis'' b' cis''  | 
 d''4. a'8 d'' fis''  | 
 a''-( g''-) fis''-( e''-) e''-( d''-)  | 
 d''4 cis'' cis''  | 
 cis'' b' cis''  | 
 d''4. a'8 d'' fis''  | 
 d''4. a'8 d'' fis''  | 
 d''4 d'' e''  | 
 d''2 
 } %( endrepeat )% 
\repeat volta 2 { 
 d''4  | 
 d'' cis''8 d'' e'' d''  | 
 b'2.  | 
 b'4 a'8 b' d'' c''  | 
 a'2.  | 
 g'4. a'8 b' cis''  | 
 cis''4 d'' d'  | 
 g' g'8 g' g' g'  | 
 g'2 g'4  | 
 b' b'8 b' b' b'  | 
 b'2 d''4  | 
 d'' cis'' cis''  | 
 cis'' b' cis''  | 
 d''4. a'8 d'' fis''  | 
 d''4. a'8 d'' fis''  | 
 d''4 d'' e''  | 
  } 
\alternative { 
  {  
 \set Timing.measureLength = #(ly:make-moment 1/2)
 d''2   |
 } %( endrepeat )% 
 
 { % beginalt
 \set Timing.measureLength = #(ly:make-moment 3/4)
 d''2.  }} 
 \bar "|." |
 