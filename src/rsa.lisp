(in-package #:rsa)

(defun range (begin end &optional (step 1))
  (cond ((<= begin end)
		 (cons begin (range (+ begin step) end step)))
		(t nil)))

(defun mirror-rabin-test (value)
  (let ((v value))
	(loop for i from 5 to (1- value) by 6
	   until (or (null v) (> i value))
	   do
		 (when (or (zerop (mod value i)) (zerop (mod value (+ i 2))))
		   (setf v nil)))
	v))

(defun random-prime (begin end)
  (let ((rd (random (+ begin (random end)))))
	(cond ((mirror-rabin-test rd)
		   rd)
		  (t (random-prime begin end)))))

(defun generate-key (p q)
  (let* ((n (* p q))
		 (l (lcm (1- p) (1- q)))
		 (e (find-if #'(lambda (x) (= (gcd x l) 1)) (range 2 l)))
		 (d (find-if #'(lambda (x) (= (mod (* e x) l) 1)) (range 2 l))))
	(list (list e n) (list d n))))

(defun encrypt (plain-text keys)
  (let ((plain-text-integers
		 (mapcar #'char-code (concatenate 'list plain-text))))
	(mapcar #'(lambda (x) (mod (expt x (car keys)) (cadr keys)))
			plain-text-integers)))

(defun decrypt (plain-text keys)
  (let ((plain-text-integers
		 (mapcar #'char-code (concatenate 'list plain-text))))
	(mapcar #'(lambda (x) (mod (expt x (car keys)) (cadr keys)))
			plain-text-integers)))

(defun decrypt (encrypted-text keys)
  )
