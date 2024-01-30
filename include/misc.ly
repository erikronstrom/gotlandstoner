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

noteheadDottedHalf = {
  \once \override NoteHead.stencil = #ly:text-interface::print
  \once \override NoteHead.text = \markup {
    \musicglyph #"noteheads.s1"
  }
}

parserDefine = #(define-void-function (name val)(symbol? scheme?)
    (ly:parser-define! name val))

defineNoteheadTweak =
    \parserDefine tweakNoteheadHalf #(define-music-function
        ( note )
        ( ly:music? )
        #{ \tweak stencil #ly:text-interface::print \tweak text \markup { \musicglyph #"noteheads.s1" } $note #}
        )

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

pizz = \markup { \italic "pizz." }
colArco = \markup { \left-align \italic "col’ arco" }


% angle brackets cause SVG error so reformat:
% #<Mom 1> becomes [Mom 1]
#(define (reformat-moment mom)
   (let* ((mom (format #f "~a" mom))
          (mom (string-drop mom 2))
          (mom (string-drop-right mom 1)))
     (string-concatenate (list "[" mom "]"))))

% grob name + absolute moment + (system) coordinates should be enough for a unique id...
#(define (get-svg-attributes grob)
   (let ((sys (ly:grob-system grob)))
     (list
      (cons 'class
        (symbol->string (grob::name grob)))
      (cons 'data-when
        (reformat-moment (grob::when grob)))
        )))

      %(cons 'x-pos
      %  (number->string (ly:grob-relative-coordinate grob sys X)))
      %(cons 'y-pos
      %  (number->string (ly:grob-relative-coordinate grob sys Y)))



%#(define (get-pitch grob) 
%  (string-concatenate 
%    (list 
%      "NoteHead/" 
%      (number->string 
%        (ly:pitch-semitones 
%          (ly:event-property (ly:grob-property grob 'cause) 'measurePosition)))))
