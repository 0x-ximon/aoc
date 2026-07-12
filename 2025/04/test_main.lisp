(load "lib.lisp")

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

(defun assert-equal (expected actual)
  (if (= expected actual)
      (format t "Assertion Passed~%")
      (format t "Assertion Failed; expected: ~A, actual: ~A~%" expected actual)))

(defun test-main ()
  (let ((first_expected 13)
        (first_result (part-one *data*))
        (second_expected 43)
        (second_result (part-two *data*)))

    (assert-equal first_expected first_result)
    (assert-equal second_expected second_result)))

(test-main)
