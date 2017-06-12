
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
  }
}

\paper {
  line-width = 130\mm
  ragged-bottom = ##t
  print-page-number = ##f
  ragged-last = ##f
}

\relative c'' {
  \time 3/4
  \key d \major
  \partial 8
  a8\accent\upbow |
  a(\downbow d) fis(\upbow d) a\downbow g\upbow |
  fis(\accent d) fis( a) d\downbow e\upbow |
  fis(\accent e) g( e) cis\downbow a\upbow |
  a(\accent cis) e( g) b\downbow a\upbow
  \bar "|."
}


