{
\time 3/4
\key f \major
\partial 4

 a'4  | 
 c''2 a'4  | 
 f'2 a'4  | 
 c''2 bes'8-( a'-)  | 
 g'2 a'4  | 
 c''2 a'4  | 
 f'2 a'4  | 
 c''2 bes'8-( a'-)  | 
 a'4 g' r  | 
 r r f' 
\repeat volta 2 { 
 d''4.-( e''8-) f''-( d''-)  | 
 c''4.-( a'8-) c''4  | 
 bes'4.-( g'8-) bes'4  | 
 \override Script.padding = #0.7
 a'8-( c''-) f''4-\fermata a'  | 
 g'4.-( bes'8-) g'4  | 
 f'4.-( e'8-) f'4  | 
 f''2 c''4  | 
  } 
\alternative { 
 {  f''2-\fermata f'4   |
 } %( endrepeat )% 
 
 { % beginalt
 f'2 }} 
 \bar "|."
 }
 \addlyrics {
     \set stanza = #"1. "
     Gräs -- hop -- pan, som i skog ock __ mark har sjun -- git he -- la
     som -- marn __ ö -- ver, nu sak --  -- nar __ hon, __ vad hon __ be -- 
     hö --  -- ver, när vin --  -- ter -- da --  -- gen kom -- mer stark. Nu stark.
}
