
\version "2.18.2"

\header{
  tagline = ""
}

\layout {
  indent = 0\cm
  \context {
    \Score
    \omit BarNumber
  }
}

\paper {
  line-width = 130\mm
  ragged-bottom = ##t
  print-page-number = ##f
  ragged-last = ##f
}

\relative c''' {
  \time 3/4
  \key g \minor
  \partial 8
  g8\upbow
  |
  g8(_\accent\downbow fis16 g)
  d4_\accent\upbow
  bes'8._\accent\downbow a16
  |
  a8_\accent\downbow g\upbow
  g16(_\accent\downbow fis a fis)
  d4\upbow
  | \break
  f8._\accent\downbow es16\upbow
  d8[_\staccato\downbow d]_\staccato\upbow
  es[_\staccato\downbow g]_\staccato\upbow
  |
  d8_\accent\downbow f_\staccato\upbow
  f16(_\accent\downbow es c d)
  bes4\upbow
  \bar "|."
}


