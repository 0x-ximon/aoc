(require "asdf")
(load "lib.lisp")

(defpackage :main
  (:use :cl))

(in-package :main)

(defun main()
  (let ((content (uiop:read-file-lines "input.txt")))
    (format t "First Answer: ~A~%" (lib:first content))
    (format t "Second Answer: ~A~%" (lib:second content))))

(main)
