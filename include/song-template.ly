\version "2.18.2"

\include "../include/repeat-bracket.ly"

\header {
    tagline = ""
    
}
\layout {
    indent = 1.4\cm
}
\paper {
    %top-margin = 0
    %bottom-margin = 0
    line-width = 169\mm
    %left-margin = 0
    %right-margin = 0
    ragged-bottom = ##t
    system-system-spacing = 
      #'((basic-distance . %((basic-distance))%)
         (minimum-distance . %((minimum-distance))%)
         (padding . %((padding))%)
         (stretchability . 12))
}
  
#(set-global-staff-size 20)

\score { {
    
    \set Staff.instrumentName = \markup { \huge \bold "%((tune-num))%." \hspace #1.2 } 
    \set Staff.shortInstrumentName = ""
    \override Score.BarNumber #'stencil = ##f
    \set Timing.beamHalfMeasure = ##f
    \override Score.VoltaBracket #'Y-extent = #'(-2.0 . 1.0)
    

%((notes))%

 
} }

\layout {
    \context {
      \Score
          \override SpacingSpanner #'common-shortest-duration = #(ly:make-moment %((note-spacing))% 64)
    }
} 
