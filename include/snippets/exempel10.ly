
\version "2.18.2"

\header{
  tagline = ""
}

\layout {
  indent = 0\cm
  \context {
    \Score
    \omit BarNumber
    % \overrideTimeSignatureSettings 3/4 1/4 #'(1 1 1) #'()
    \override SpacingSpanner.base-shortest-duration = #(ly:make-moment 1/16)
  }
}

\paper {
  line-width = 130\mm
  ragged-bottom = ##t
  print-page-number = ##f
  ragged-last = ##t
}

\relative c'' {
  \time 3/4
  \key g \major
  d4._\accent\downbow c8(\upbow b c) |
  e4._\accent\downbow c8(\upbow e g) |
  fis4._\accent\downbow d8(\upbow fis a) | \break
  g8(_\accent\downbow fis g a) b4\upbow |
  d,4._\accent\downbow b8(\upbow d g) |
  \bar "|."
}


