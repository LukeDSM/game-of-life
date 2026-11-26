(defpackage #:game-of-life/demo
  (:use #:cl #:gol)
  (:nicknames #:gol/demo)
  (:export
   #:play
   #:glider))

(in-package #:game-of-life/demo)

(defun play (world &optional (clear-term nil))
  (dotimes (i (array-dimension world 0))
    (if clear-term
        (format t "~c[2J~c[H" #\Esc #\Esc)
        (format t "~%"))
    (print-world world :gen i)
    (sleep 0.25)))

(defun glider ()
  (make-world 10 10 32 '(1 0) '(2 1) '(2 2) '(1 2) '(0 2)))
