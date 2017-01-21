\version "2.18.2"

\include "../include/repeat-bracket.ly"
\include "../include/flat-beams.ly"
\include "../include/text-braces.ly"
\include "../include/misc.ly"

\header {
    tagline = ""
    
}
\layout {
    indent = %((indent))%\cm
    \context {
        \Lyrics
        \override LyricText #'font-size = #-1
        \override StanzaNumber.font-series = #'medium
        \override StanzaNumber.font-size = #-1
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
    %((page-width))%%
    paper-height = %((page-height))%
    ragged-bottom = ##t
    print-page-number = ##f
    system-system-spacing = 
      #'((basic-distance . %((basic-distance))%)
         (minimum-distance . %((minimum-distance))%)
         (padding . %((padding))%)
         (stretchability . 12))
    %((page-count))%
}


\score { {
    
    \set Staff.instrumentName = \markup { %((tune-num-font))% \abs-fontsize #18 { \bold "%((tune-num))%." } \hspace #0.7 } 
    \set Staff.shortInstrumentName = ""
    \override Score.BarNumber #'stencil = ##f
    \set Timing.beamHalfMeasure = ##t
    \override Score.VoltaBracketSpanner #'outside-staff-padding = #2
    \override Score.NoteHead.output-attributes = #get-svg-attributes
    
%((time-settings))%    

%((tempo))%
%((notes))%

 
} }

\layout {
    \context {
      \Score
          \override SpacingSpanner #'common-shortest-duration = #(ly:make-moment %((note-spacing))% 64)
    }
} 
