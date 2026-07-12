(load "lib.lisp")

(defpackage :test
  (:use :cl)
  (:shadow :assert))

(in-package :test)

(defvar *data*
  (list "..@@.@@@@."
        "@@@.@.@.@@"
        "@@@@@.@.@@"
        "@.@@@@..@."
        "@@.@@@@.@@"
        ".@@@@@@@.@"
        ".@.@.@.@@@"
        "@.@@@.@@@@"
        ".@@@@@@@@."
        "@.@.@@@.@."))

(defun assert (expected actual)
  (if (= expected actual)
      (format t "Assertion Passed~%")
      (format t "Assertion Failed; expected: ~A, actual: ~A~%" expected actual)))

(defun test-main ()
  (let ((first_expected 13)
        (first_result (lib:first *data*))
        (second_expected 43)
        (second_result (lib:second *data*)))

    (assert first_expected first_result)
    (assert second_expected second_result)))

(test-main)
