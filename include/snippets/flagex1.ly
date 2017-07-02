\version "2.18.2"

\header{
  tagline = ""
}

\layout {
      		\remove "Time_signature_engraver"
      		\remove "Clef_engraver"
		}
	}


smallFlageolet =
#(let ((m (make-articulation "flageolet")))
   (set! (ly:music-property m 'tweaks)
         (acons 'font-size -3
                (ly:music-property m 'tweaks)))
   m)

\relative c' {
  %\override Staff.StaffSymbol.transparent = ##t
  s8 d4-4\smallFlageolet s8 c4\smallFlageolet
}