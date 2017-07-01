\version "2.18.2"

\header{
  tagline = ""
}

\layout {    	indent = 0\in    	\context {      		\Staff      		% \remove "Staff_symbol_engraver"
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

\relative c'' {
  %\override Staff.StaffSymbol.transparent = ##t
  s32 d16[ b d b] s64
}