(in-package #:cl-iouring)

(defclass ring ()
  ((ring :initform (cffi:foreign-alloc '(:struct io_uring)) :accessor ring)
   (flags :initarg :flags :initform 0 :accessor flags)
   (entries :initarg :entries :initform (error "You must supply the ring size") :accessor entries)))

(defmethod initialize-instance :after ((ring ring) &key)
  (io_uring_queue_init (entries ring) (ring ring) (flags ring))
  (let ((cring (ring ring)))
    (trivial-garbage:finalize ring
                              (lambda ()
                                ;; TODO: remove format messages
                                (format t "Freeing~%")
                                (format t "Freeing ~D~%" (io_uring_queue_exit cring))
                                (cffi:foreign-free cring)))))

(defmethod get-sqe ((ring ring))
  (io_uring_get_sqe (ring ring)))

(defmethod read-file ((ring ring) (path string) &key (directory +at-fdcwd+))
  ;; TODO if directory is passed to us, get an fd on that
  (let* ((sqe (io_uring_get_sqe (ring ring)))
         (cqe (cffi:foreign-alloc '(:struct io_uring_cqe)))
         (size (osicat-posix:stat-size (osicat-posix:stat path)))
         (fd (osicat-posix:openat directory path osicat-posix:o-rdonly))
         (buf (cffi:make-shareable-byte-vector size)))
    (cffi:with-pointer-to-vector-data (buf buf)
      (io_uring_prep_read sqe fd buf size 0)
      (io_uring_submit (ring ring))
      (let ((ret (io_uring_wait_cqe (ring ring) cqe)))
        (when (< ret 0)
          (error "Error waiting for completion"))
        (cffi:foreign-free cqe)
        (osicat-posix:close fd)
        (cffi:foreign-string-to-lisp buf)))))
