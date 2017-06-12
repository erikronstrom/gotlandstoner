
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
  \key d \major
  a16(_\accent\upbow fis) d\downbow( fis)
  a16(_\accent\upbow fis) d\downbow( fis)
  a16(_\accent\upbow fis) d\downbow( fis)
  |
  a16(_\accent\upbow e) cis\downbow( e)
  a16(\upbow e) cis\downbow( e)
  a16(\upbow e) cis\downbow( e)
  \bar "|."
}


