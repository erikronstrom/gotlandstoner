
\version "2.18.2"

\header{
  tagline = ""
}

\layout {
  indent = 0\cm
  \context {
    \Score
    \omit BarNumber
    \overrideTimeSignatureSettings 3/4 1/4 #'(1 1 1) #'()

  }
}

\paper {
  line-width = 130\mm
  ragged-bottom = ##t
  print-page-number = ##f
  ragged-last = ##f
}

\relative c' {
  \time 3/4
  \key c \major
  % \set Timing.beamHalfMeasure = ##f
  c8(_\accent\downbow e) g(\upbow c) e\downbow c\upbow |
  c8(_\accent\downbow b) b(\upbow g) b\downbow d\upbow | \break
  f8(_\accent\downbow e) f(\upbow a) g\downbow b,\upbow |
  c8(_\accent\downbow d) e(\upbow c) g\downbow e\upbow |
  \bar "|."
}


