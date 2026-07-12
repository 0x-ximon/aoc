(defvar *directions*
  (list  (list -1 -1) (list -1  0) (list -1  1)
         (list  0 -1)              (list  0  1)
         (list  1 -1) (list  1  0) (list  1  1)))

(defun part-one (data)
  (let ((result 0)
        (m (list-length data))
        (n (length (nth 0 data))))

    (loop for i from 0 to (- m 1) do
          (loop for j from 0 to (- n 1) do
                (let ((count 0)
                      (c (char (nth i data) j)))

                  (when (char= c #\@)
                    (loop for dir in *directions* do
                          (let ((x (+ i (nth 0 dir)))
                                (y (+ j (nth 1 dir))))

                            (when (and (>= x 0) (< x m)
                                       (>= y 0) (< y n))

                              (let ((d (char (nth x data) y)))
                                (when (char= d #\@)
                                  (incf count))))))

                    (when (< count 4)
                      (incf result))))))
    result))

(defun part-two (data)
  (let ((result 0)
        (m (list-length data))
        (n (length (nth 0 data))))

    result))
