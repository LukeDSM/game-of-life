(defsystem "game-of-life"
  :description "A library for Conway's Game of Life represented via 2+1d arrays."
  :version "1.0.0"
  :author "LukeDSM"
  :license "MIT"
  :components ((:file "game-of-life")))

(defsystem "game-of-life/demo"
  :description "A set of demonstrations for the game-of-life library."
  :author "LukeDSM"
  :license "MIT"
  :depends-on ("game-of-life")
  :components ((:file "demo")))
