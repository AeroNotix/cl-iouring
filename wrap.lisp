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

(defmethod readv-file ((ring ring) (path string) &key (block-size 1024))
  (let* ((ring (ring ring))
         (sqe (io_uring_get_sqe ring))
         (cqe (cffi:foreign-alloc '(:struct io_uring_cqe)))
         (size (osicat-posix:stat-size (osicat-posix:stat path)))
         (bytes-remaining size)
         (fd (osicat-posix:open path osicat-posix:o-rdonly))
         (required-blocks (+ (floor size block-size) (if (zerop (mod size block-size))
                                                         0 1)))
         ;; TODO: readv (and friends) only allow iovecs of len
         ;; +uio-maxiov+, so we need to chunk up the readvs.  We would
         ;; essentially submit N sqes rather than yeet them all
         ;; together in a single submission, then use io-uring linking
         ;; to retrieve them.
         ;; (sqe-chunks (ceiling required-blocks +uio-maxiov+))
         (buf (cffi:make-shareable-byte-vector size)))
    (cffi:with-foreign-object (iovecs '(:struct osicat-posix::iovec) required-blocks)
      (cffi:with-pointer-to-vector-data (buf buf)
        (dotimes (i required-blocks)
          (let ((bytes-to-read (if (> bytes-remaining block-size)
                                   block-size
                                   bytes-remaining))
                (ptr (cffi:mem-aptr iovecs '(:struct osicat-posix::iovec) i)))
            (decf bytes-remaining bytes-to-read)
            (setf (cffi:foreign-slot-value ptr '(:struct osicat-posix::iovec) 'osicat-posix::len) bytes-to-read)
            (setf (cffi:foreign-slot-value ptr '(:struct osicat-posix::iovec) 'osicat-posix::base) (cffi:inc-pointer buf (* i block-size)))))
        (io_uring_prep_readv sqe fd iovecs required-blocks 0)
        (io_uring_submit ring)
        ;; (when (< (io_uring_wait_cqe ring cqe) 0)
        ;;   (error "Error waiting for completion"))
        ;; (when (< (cffi:foreign-slot-value cqe '(:struct io_uring_cqe) 'res) 0)
        ;;   (error "Async readv failed"))
        (io_uring_cqe_seen ring cqe)
        (osicat-posix:close fd)
        (cffi:foreign-string-to-lisp buf)))))
