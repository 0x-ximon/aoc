(require "asdf")
(load "meta.lisp")

(defun main() 
  (let ((content (uiop:read-file-lines "input.txt")))
    (format t "Answer: ~A~%" (process content))))

(main)
