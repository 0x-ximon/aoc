(load "meta.lisp")

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

(defun test_main () 
  (let ((expected 13) 
        (actual (process *data*)))

    (if (= actual expected) 
        (format t "Test Passed~%") 
        (format t "Test Failed; expected: ~A, actual: ~A~%" expected actual))))

(test_main)
