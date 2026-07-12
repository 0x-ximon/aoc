(require "asdf")
(load "lib.lisp")

(defun main()
  (let ((content (uiop:read-file-lines "input.txt")))
    (format t "First Answer: ~A~%" (part-one content))
    (format t "Second Answer: ~A~%" (part-two content))))

(main)
