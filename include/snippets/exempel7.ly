
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
  \key g \minor
  d16(_\accent\downbow c) es(\upbow d)
  d(_\accent\downbow c) d(\upbow c)
  bes(_\accent\downbow a) g(\upbow fis)
  |
  g(_\accent\downbow bes) d(\upbow fis)
  g(_\accent\downbow a bes g)
  d4_\accent\upbow
  \bar "|."
}


