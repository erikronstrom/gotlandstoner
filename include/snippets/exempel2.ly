
\version "2.18.2"

\header {
  tagline = ""
}

\paper {
  line-width = 130\mm
  ragged-bottom = ##t
  print-page-number = ##f
  ragged-last = ##f
}


\layout {
  indent = 0\cm
  \context {
    \Score
    \omit BarNumber
  }
  \context {
    \Staff
    \override VerticalAxisGroup.default-staff-staff-spacing =
      #'((basic-distance . 18)
         (minimum-distance . 7)
         (padding . 1))
  }
}

\relative c'' {
  \time 3/4
  \key a \major
  fis16(_\accent\downbow e d cis)
  d(_\accent\upbow e fis e)
  d(_\accent\downbow cis b a)
  |
  fis'16(_\accent\upbow e d cis)
  d(_\accent\downbow e fis e)
  d(_\accent\upbow cis b a)
  | \break
  gis16(_\accent\downbow a b cis)
  d(_\accent\upbow e fis gis)
  a8._\accent\downbow a,16\upbow
  |
  cis16(_\accent\downbow a b gis)
  a4\upbow a,\downbow \bar "|."
}


