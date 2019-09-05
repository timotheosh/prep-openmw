;;;; prep-openmw.asd
;;
;;;; Copyright (c) 2019 Tim Hawes


(asdf:defsystem #:prep-openmw
  :description "Describe prep-openmw here"
  :author "Tim Hawes"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:ppath)
  :components ((:file "package")
               (:file "prep-openmw"))
  :build-operation "asdf:program-op"
  :build-pathname "target/emacs-term"
  :entry-point "prep-openmw:-main")
