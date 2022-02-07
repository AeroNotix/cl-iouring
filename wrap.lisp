(in-package #:cl-iouring)

(defclass ring ()
  ((ring :initform (cffi-helpers:safe-foreign-alloc '(:struct io_uring)) :accessor ring)
   (cqe :initform (cffi-helpers:safe-foreign-alloc '(:struct io_uring_cq)) :accessor cqe)
   (sqe  :initform (cffi-helpers:safe-foreign-alloc '(:struct io_uring_sq)) :accessor sqe)
   (flags :initarg :flags :initform 0 :accessor flags)
   (entries :initarg :entries :initform (error "You must supply the ring size") :accessor entries)))

(defmethod initialize-instance :after ((ring ring) &key)
  (io_uring_queue_init (entries ring) (ring ring) (flags ring))
  (let ((cring (ring ring))
        (cqe (cqe ring))
        (sqe (sqe ring)))
    (trivial-garbage:finalize ring
                              (lambda ()
                                ;; TODO: remove format messages
                                (format t "Freeing~%")
                                (format t "Freeing ~D~%" (io_uring_queue_exit cring))
                                (cffi:foreign-free cring)
                                (cffi:foreign-free sqe)
                                (cffi:foreign-free cqe)))))

(defmethod get-sqe ((ring ring))
  (io_uring_get_sqe (ring ring)))

(defmethod read-file ((ring ring) (path string) &key (directory +at-fdcwd+))
  (let ((sqe (io_uring_get_sqe (ring ring))))
    ;; TODO if directory is passed to us, get an fd on that
    (io_uring_prep_openat sqe directory path 0 0)))
