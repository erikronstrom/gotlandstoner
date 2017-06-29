{
\time 3/4
\key c \major

\repeat volta 2 { 
 \partial 4
 g'4  | 
 c'' e'' g''  | 
 g'' e'' c''  | 
 c'' e'' g''  | 
 f''2 a''4  | 
  f'' a'' a''  | 
 g'' r e''8 c''  | 
 f''4 d'' b'  | 
  } 
\alternative { 
 {  
 \set Timing.measureLength = #(ly:make-moment 2/4)
 c''2
 } %( endrepeat )% 
 
 { % beginalt
 \set Timing.measureLength = #(ly:make-moment 3/4)
 c''2.   }} 
 
\repeat volta 2 { 
 f''4 a''8 f'' a''4  | 
 e'' g''8 e'' g''4  | 
 d'' f'' d''  | 
 c'' e''8 g'' c'''4  | 
  f'' a''8 f'' a''4  | 
 e'' g''8 e'' g'' r  | 
 d''4 f'' b'  | 
  } 
\alternative { 
 {  c''2 r4   |
 } %( endrepeat )% 
 
 { % beginalt
 c''2  }} 
 \bar "|."
  }
 \addlyrics {
     Skou -- ma -- kan han si -- tar bäi bäŋ -- ken u dund -- rar,
     dund -- rar u svär, För han ai far någn mat. mat.
     Tra -- la -- la -- la tra -- la -- la -- la tra -- la -- la -- la -- la -- la -- la,
     tra -- la -- la -- la, tra -- la -- la -- la, tra -- la -- la -- la. la.
}
