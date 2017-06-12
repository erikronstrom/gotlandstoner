
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
}

\relative c'' {
  \time 3/4
  \key c \major
  \override Stem.direction = #DOWN
  \override PhrasingSlur.outside-staff-priority = #500
  e16.(\accent g32) e16( c)_\(
  e16.(\accent\) g32) e16( c)_\(
  e16.(\accent\) g32) e16( c)_\(
  | \noBreak
  b16.(\accent\) d32) b16( g)_\(
  b16.(\accent\) d32) b16( g)_\(
  b16.(\accent\) d32) b16( g)_\(
  | \break
  a16.(\accent\) c32) a16( f)_\(
  a16.(\accent\) c32) a16( f)_\(
  a16.(\accent\) c32) a16( f)_\(
  |
  e16.(\accent\) g32) e16( c)_\(
  e16.(\accent\) g32) e16( c)
  \override Stem.direction = #UP
  g4
  \bar "|."
}


