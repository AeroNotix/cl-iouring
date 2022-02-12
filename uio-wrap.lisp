(in-package #:iouring-sys)

(defun iovec-base (iovec)
  (cffi:foreign-slot-value iovec '(:struct iovec) 'base))

(defun (setf iovec-base) (base iovec)
  (setf (cffi:foreign-slot-value iovec '(:struct iovec) 'base) base))

(defun iovec-len (iovec)
  (cffi:foreign-slot-value iovec '(:struct iovec) 'len))

(defun (setf iovec-len) (len iovec)
  (setf (cffi:foreign-slot-value iovec '(:struct iovec) 'len) len))
