% repeatBracket snippet
% will add .----Nx----. above a bar, where N is the number of repetitions
% based on the wonderful spanner by David Nalesnik (see: http://lists.gnu.org/archive/html/lilypond-user/2014-10/msg00446.html )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LSR workaround:
% #(set! paper-alist (cons '("snippet" . (cons (* 200 mm) (* 60 mm))) paper-alist))
% \paper {
%   #(set-paper-size "snippet")
%   tagline = ##f
% }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (test-stencil grob text)
   (let* ((orig (ly:grob-original grob))
          (siblings (ly:spanner-broken-into orig)) ; have we been split?
          (refp (ly:grob-system grob))
          (left-bound (ly:spanner-bound grob LEFT))
          (right-bound (ly:spanner-bound grob RIGHT))
          (elts-L (ly:grob-array->list (ly:grob-object left-bound 'elements)))
          (elts-R (ly:grob-array->list (ly:grob-object right-bound 'elements)))
          (break-alignment-L
           (filter
            (lambda (elt) (grob::has-interface elt 'break-alignment-interface))
            elts-L))
          (break-alignment-R
           (filter
            (lambda (elt) (grob::has-interface elt 'break-alignment-interface))
            elts-R))
          (break-alignment-L-ext (ly:grob-extent (car break-alignment-L) refp X))
          (break-alignment-R-ext (ly:grob-extent (car break-alignment-R) refp X))
          (num
           (markup text))
          (num
           (if (or (null? siblings)
                   (eq? grob (car siblings)))
               num
               (make-parenthesize-markup num)))
          (num (grob-interpret-markup grob num))
          (num-stil-ext-X (ly:stencil-extent num X))
          (num-stil-ext-Y (ly:stencil-extent num Y))
          (num (ly:stencil-aligned-to num X CENTER))
          (num
           (ly:stencil-translate-axis
            num
            (+ (interval-length break-alignment-L-ext)
              (* 0.5
                (- (car break-alignment-R-ext)
                  (cdr break-alignment-L-ext))))
            X))
          (bracket-L
           (markup
            #:path
            0.1 ; line-thickness
            `((moveto 0.5 ,(* 0.5 (interval-length num-stil-ext-Y)))
              (lineto ,(* 0.5
                         (- (car break-alignment-R-ext)
                           (cdr break-alignment-L-ext)
                           (interval-length num-stil-ext-X)))
                ,(* 0.5 (interval-length num-stil-ext-Y)))
              (closepath)
              (rlineto 0.0
                ,(if (or (null? siblings) (eq? grob (car siblings)))
                     -1.0 0.0)))))
          (bracket-R
           (markup
            #:path
            0.1
            `((moveto ,(* 0.5
                         (- (car break-alignment-R-ext)
                           (cdr break-alignment-L-ext)
                           (interval-length num-stil-ext-X)))
                ,(* 0.5 (interval-length num-stil-ext-Y)))
              (lineto 0.5
                ,(* 0.5 (interval-length num-stil-ext-Y)))
              (closepath)
              (rlineto 0.0
                ,(if (or (null? siblings) (eq? grob (last siblings)))
                     -1.0 0.0)))))
          (bracket-L (grob-interpret-markup grob bracket-L))
          (bracket-R (grob-interpret-markup grob bracket-R))
          (num (ly:stencil-combine-at-edge num X LEFT bracket-L 0.4))
          (num (ly:stencil-combine-at-edge num X RIGHT bracket-R 0.4)))
     num))

#(define-public (Measure_attached_spanner_engraver context)
   (let ((span '())
         (finished '())
         (event-start '())
         (event-stop '()))
     (make-engraver
      (listeners ((measure-counter-event engraver event)
                  (if (= START (ly:event-property event 'span-direction))
                      (set! event-start event)
                      (set! event-stop event))))
      ((process-music trans)
       (if (ly:stream-event? event-stop)
           (if (null? span)
               (ly:warning "You're trying to end a measure-attached spanner but you haven't started one.")
               (begin (set! finished span)
                 (ly:engraver-announce-end-grob trans finished event-start)
                 (set! span '())
                 (set! event-stop '()))))
       (if (ly:stream-event? event-start)
           (begin (set! span (ly:engraver-make-grob trans 'MeasureCounter event-start))
             (set! event-start '()))))
      ((stop-translation-timestep trans)
       (if (and (ly:spanner? span)
                (null? (ly:spanner-bound span LEFT))
                (moment<=? (ly:context-property context 'measurePosition) ZERO-MOMENT)) 
           (ly:spanner-set-bound! span LEFT 
             (ly:context-property context 'currentCommandColumn)))
       (if (and (ly:spanner? finished)
                (moment<=? (ly:context-property context 'measurePosition) ZERO-MOMENT))
           (begin
            (if (null? (ly:spanner-bound finished RIGHT))
                (ly:spanner-set-bound! finished RIGHT
                  (ly:context-property context 'currentCommandColumn)))
            (set! finished '())
            (set! event-start '())
            (set! event-stop '()))))
      ((finalize trans)
       (if (ly:spanner? finished)
           (begin
            (if (null? (ly:spanner-bound finished RIGHT))
                (set! (ly:spanner-bound finished RIGHT)
                      (ly:context-property context 'currentCommandColumn)))
            (set! finished '())))
       (if (ly:spanner? span)
           (begin
            (ly:warning "I think there's a dangling measure-attached spanner :-(")
            (ly:grob-suicide! span)
            (set! span '())))))))

% necessary layout options
% note that you can have more than one single layout block (some of them may even be outside and some inside \score)
\layout {
  \context {
    \Staff
    \consists #Measure_attached_spanner_engraver
    \override MeasureCounter.font-encoding = #'latin1
    \override MeasureCounter.font-size = 0
    \override MeasureCounter.outside-staff-padding = 1
    \override MeasureCounter.outside-staff-horizontal-padding = #0
  }
}

% function itself
repeatBracket = #(define-music-function
     (parser location N note)
     (number? ly:music?)     
      #{        
        \override Staff.MeasureCounter.stencil = 
        #(lambda (grob) (test-stencil grob #{ #(string-append(number->string N) "×") #} ))
        \startMeasureCount
        \repeat volta #N { $note }
        \stopMeasureCount
      #}
     )
     
     
textedMeasureBracket = #(define-music-function
     (parser location str mus)
     (markup? ly:music?)
     #{
       \override Staff.MeasureCounter.stencil =
       #(lambda (grob) (test-stencil grob str))
       \startMeasureCount
       #mus
       \stopMeasureCount
       #}
     )

twice = \markup { \italic "bis" }

%%%%%%%%%%%%%%%%%%%%%% EXAMPLE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% {
%   \repeatBracket 7 {c'1}
%   \repeatBracket 32 {d' g}
%   \repeatBracket 14 {e' f g}
%   \repeatBracket 29 {f' a bes \break cis' e''}
%   \repeatBracket 1048 {g'1}
% }