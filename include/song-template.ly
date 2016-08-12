\version "2.18.2"

\include "../include/repeat-bracket.ly"
\include "../include/flat-beams.ly"

\header {
    tagline = ""
    
}
\layout {
    indent = 1.4\cm
    \context {
        \Lyrics
        \override LyricText #'font-size = #-1
        %\override LyricText #'font-name = #"CMU Serif"
    }
    %\context {
    %    \Staff
    %    \override TextScript #'font-name = #"CMU Serif"
    %}
}

#(set-global-staff-size 20)

\paper {
    #(define fonts
      (make-pango-font-tree
        "CMU Serif"
        "Arial"
        "LMMono10"
        (/ staff-height pt 20)))
    %top-margin = 0
    %bottom-margin = 0
    line-width = 169\mm
    %left-margin = 0
    %right-margin = 0
    paper-height = 240mm
    ragged-bottom = ##t
    print-page-number = ##f
    system-system-spacing = 
      #'((basic-distance . %((basic-distance))%)
         (minimum-distance . %((minimum-distance))%)
         (padding . %((padding))%)
         (stretchability . 12))
    
}


\score { {
    
    \set Staff.instrumentName = \markup { \huge \bold "%((tune-num))%." \hspace #1.2 } 
    \set Staff.shortInstrumentName = ""
    \override Score.BarNumber #'stencil = ##f
    \set Timing.beamHalfMeasure = ##t
    \override Score.VoltaBracketSpanner #'outside-staff-padding = #2
    
%((time-settings))%    

%((notes))%

 
} }

\layout {
    \context {
      \Score
          \override SpacingSpanner #'common-shortest-duration = #(ly:make-moment %((note-spacing))% 64)
    }
} 