flatBeams = \override Beam #'damping = #+inf.0
normalBeams = \revert Beam #'damping
flatBeam = \once \override Beam #'damping = #+inf.0

leftbrace = \set stanza = \markup {
  \hspace #1
  \translate #'(0 . 0.4) \left-brace #22 }

rightbrace = \set stanza = \markup {
%  \hspace #1
  \translate #'(0 . 0.4) \right-brace #22
  \hspace #1 } 