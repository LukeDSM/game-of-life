(defpackage #:game-of-life
  (:use #:cl)
  (:nicknames #:gol)
  (:export
   #:cell
   #:neighbors
   #:make-world
   #:print-world))

(in-package #:game-of-life)

(defun cell (world x y gen)
  (aref world gen y x))

(defun (setf cell) (state world x y gen)
  (setf (aref world gen y x) state))

(defun neighbors (world x y gen)
  (let ((w (array-dimension world 2))
        (h (array-dimension world 1))
        (count 0))
    (loop for dy from (1- y) to (1+ y)
          do (loop for dx from (1- x) to (1+ x)
                   when (and (or (/= dy y) (/= dx x))
                             (<= 0 dy (1- h))
                             (<= 0 dx (1- w))
                             (cell world dx dy gen))
                     do (incf count)))
    count))

(defun make-world (w l time &rest initial-cells)
  (let ((world (make-array (list time l w) :initial-element nil)))
    ;; Initialize the world's starting point
    (dolist (coords initial-cells)
      (let ((x (first coords))
            (y (second coords)))
        (setf (cell world x y 0) t)))
    ;; Generate each time frame afterwards
    (unless (= time 1)
      (loop for gen from 1 to (1- time)
            do (dotimes (y l)
                 (dotimes (x w)
                   (let* ((prev (1- gen))
                          (nb (neighbors world x y prev)))
                     (cond ((or (< nb 2) (> nb 3))
                            (setf (cell world x y gen) nil))
                           ((= nb 3)
                            (setf (cell world x y gen) t))
                           (t
                            (setf (cell world x y gen) (cell world x y prev)))))))))
    world))

(defun print-world (world &key (gen 0) (stream t) (living-cell #\+) (dead-cell #\-))
  (let ((w (array-dimension world 2)))
    (dotimes (y (array-dimension world 1))
      (dotimes (x w)
        (format stream "~a~a"
                (if (cell world x y gen)
                    living-cell
                    dead-cell)
                (if (= x (1- w))
                    ""
                    #\Space)))
      (format stream "~%"))))
