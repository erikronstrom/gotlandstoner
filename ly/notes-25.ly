{
\time 3/4
\key a \minor

 \partial 8
 e'8  | 
 a' b' c''8.-( b'16-) a'8 b'  | 
 c'' d'' \once \override Script.padding = #0.7 e''4.-\fermata r8  | 
 g''4-> e''-> c''->  | 
 \override TextScript.outside-staff-padding = 1.5
 d''^\markup { \center-align \italic "ritard." } \once \override Script.padding = #0.7 e''-\fermata r8 b'  | 
 c''8. d''16 e''4 e''8. e''16  | 
 e''8.-> d''16 d''4-\fermata r8 d''  | 
 c'' b' a'-( b'-) c''8. a'16  | 
 b'4-\fermata b'-\fermata r8 b'  | 
 c'' d'' e''4 e''8. e''16  | 
 e''8.-> d''16 d''4-\fermata r8 e''  | 
 c''8. b'16 a'8-( b'-) c''8. a'16  | 
 b'4 a' r8 \bar "|."
 }
 \addlyrics {
     \set stanza = #"1. "
     Ma -- le -- na stod på den hö -- gan
     \once \override LyricText.self-alignment-X = #-0.8 "bro  —" so -- len sken
     rö -- dan. Då him -- lens Här -- re för hän -- ne stod, allt
     un -- der lin --  -- den den grö -- na, då him -- lens Här -- re för
     hän -- ne stod, allt un -- der lin --  -- den den grö -- na.
}
