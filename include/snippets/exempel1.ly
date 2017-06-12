
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
  \partial 8
  \override Stem.direction = #DOWN
  \override PhrasingSlur.outside-staff-priority = #500
  e16(\upbow f16) |
  g8\downbow a16(\upbow g)_\(  g(\accent\) f)_\( e(\) f)_\( g(\accent\) e)_\( c'\) g_\( |
  g(\accent\) e)_\( a\) g_\(  f(\accent\) e)_\( d\) c_\( c(\accent\) b)_\( a\) g \bar "|."
}


