%noteheadHalf = {
%  \tweak NoteHead.stencil #ly:text-interface::print
%  \tweak NoteHead.text \markup {
%      \musicglyph #"noteheads.s1"
%  }
%}

noteheadHalf = {
  \once \override NoteHead.stencil = #ly:text-interface::print
  \once \override NoteHead.text = \markup {
    \musicglyph #"noteheads.s1"
  }
}

fine = {
  \once \override Score.RehearsalMark.direction = #DOWN
  \once \override Score.RehearsalMark #'break-visibility = #end-of-line-visible
  \once \override Score.RehearsalMark #'self-alignment-X = #RIGHT
  \mark \markup { \italic \normalsize "Fine." }
}

dcAlFine = {
  \once \override Score.RehearsalMark.direction = #DOWN
  \once \override Score.RehearsalMark #'break-visibility = #end-of-line-visible
  \once \override Score.RehearsalMark #'self-alignment-X = #RIGHT
  \mark \markup { \italic \normalsize "D. C. al Fine." }
}

smallFlageolet =
#(let ((m (make-articulation "flageolet")))
   (set! (ly:music-property m 'tweaks)
         (acons 'font-size -3
                (ly:music-property m 'tweaks)))
   m)
