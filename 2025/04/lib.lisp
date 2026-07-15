(defpackage :lib
  (:use :cl)
  (:shadow :first :second)
  (:export :first :second :*directions*))

(in-package :lib)

(defvar *directions*
  (list  (list -1 -1) (list -1  0) (list -1  1)
         (list  0 -1)              (list  0  1)
         (list  1 -1) (list  1  0) (list  1  1)))

(defun first (data)
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

(defun second (data)
  (let ((result 0)
        (m (list-length data))
        (n (length (nth 0 data))))

    (loop named forever do
          (let ((removed 0)
                (next (mapcar #'copy-seq data)))

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
                              (setf (char (nth i next) j) #\.)
                              (incf removed)
                              (incf result))))))

            (setf data next)
            (when (= removed 0)
              (return-from forever))))

    result))
