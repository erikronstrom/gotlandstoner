
\version "2.18.2"

\header{
  tagline = ""
}

\layout {
  indent = 0\cm
}

\paper {
  line-width = 130\mm
  ragged-bottom = ##t
  print-page-number = ##f
  ragged-last = ##f
}

\relative c'' {
  \time 3/4
  c16(_\accent\upbow e,) g,\downbow( c')
  c16(_\accent\upbow e,) g,\downbow( c')
  c16(_\accent\upbow e,) g,\downbow( c')
  |
  b16(_\accent\upbow f) g,\downbow( b')
  b16(_\accent\upbow f) g,\downbow( b')
  b16(_\accent\upbow f) g,\downbow( b')
  \bar "|."
}


