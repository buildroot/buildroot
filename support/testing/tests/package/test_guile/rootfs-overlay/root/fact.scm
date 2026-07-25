#! /usr/bin/env guile
!#

; Adapted from "The Guile Reference Manual"
; Section 4.3.4 Scripting Examples
; https://doc.guix.gnu.org/guile/latest/en/html_node/Scripting-Examples.html

(define (fact n)
  (if (zero? n) 1
    (* n (fact (- n 1)))))

(display (fact (string->number (cadr (command-line)))))
(newline)
