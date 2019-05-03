{
\time 4/4
\key f \major

\dynamicUp
\override DynamicLineSpanner.staff-padding = #2.3
\override TextScript.staff-padding = #1.8

\repeat volta 2 { 
 \partial 8
 bes'8\mf  | 
 a'8. g'16 a'8 g' f'8.-( g'16-) a'8. f'16  | 
 g'8^! a'^!^\markup { \italic cresc. } b'^! c''^! d''8.-> c''16 c''8.-\fermata bes'16\noBeam\p  | 
 a'8. g'16 a'8 g' f'8.-( g'16-) a'8. f'16\noBeam\pp  | 
 g'8 g' c''8.\< c''16\!\> f'4\! r8
 } %( endrepeat )% 
 
\repeat volta 2 { 
 f''\f  | 
 d''8.-> bes'16 bes'-( d''-) f''8 c''8.-> a'16 a'-( c''-) f''8  | 
 d''8.^\markup { \italic dim. } c''16 b'8^\markup { \italic ritard. } b' c''4.-\fermata bes'8\mf  | 
 a'8. g'16 a'8. g'16 f'8.-( g'16-) a'8. f'16  | 
 g'8. g'16 c''8. c''16 f'4 r8
 } %( endrepeat )% 
 }
 \addlyrics {
     \set stanza = #"1. "
     Jag står i tu -- sen tan --  -- kar ock äls -- kar den jag ej kan få, som
     här i värl -- den van -- kar, i näj -- den spörjs det så.
     Men om jag så __ till dö -- den går, visst bli -- ver syn -- den din. Tro
     al -- drig här i värl --  -- den du går ut -- ur mitt sinn.
}
