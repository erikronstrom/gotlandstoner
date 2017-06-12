\version "2.18.2"

\header{
  tagline = ""
}

\score {

	<<
		\override Staff.StaffSymbol.transparent = ##t
		% s4
  		%f'8  f'16 \melisma f' \melismaEnd f'4 f'4 \bar "|"
		f'8  f'16 f' f'4 f'4 \bar "|"
		f'8  f'16 f' f'4 f'4 \bar "|"
		\hideNotes e4
      }
		al -- la ska dan -- sa
		\once \override LyricText.self-alignment-X = #LEFT "o. s. v.»"
		}
	}
	\new Lyrics \with { alignBelowContext = "staff" \override VerticalAxisGroup.nonstaff-relatedstaff-spacing = #'((basic-distance . 5)) } {
        h.
		\once \override LyricText.self-alignment-X = #LEFT
		\markup {
			\raise #2
			\center-column {
				\rotate #90 \left-brace #24
				\raise #1 v.
			}
		}
		\skip 16
		h.
		\markup {
			\center-column {
				v.h.
				\raise #2 \rotate #90 \left-brace #18
			}
		}

		%%
		
		h.
		\once \override LyricText.self-alignment-X = #LEFT
		\markup {
			\raise #2
			\center-column {
				\rotate #90 \left-brace #24
				\raise #1 v.
			}
		}
		\skip 16
		h.
		\markup {
			\center-column {
				v.h.
				\raise #2 \rotate #90 \left-brace #18
			}
		}

		
		}
	}

	\layout {
      		\remove "Clef_engraver"
		}
		\context {
			\Lyrics
			\override LyricText #'font-size = #-2
		}
}

\paper {
    #(define fonts
      (make-pango-font-tree
        "CMU Serif"
        "Arial"
        "LMMono10"
        (/ staff-height pt 20)))
    ragged-bottom = ##t
    print-page-number = ##f
	line-width = 100\mm
	ragged-last = ##f
}

