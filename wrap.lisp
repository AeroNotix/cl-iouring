(in-package #:iouring)

(defclass ring ()
  ((ring :initform (cffi:foreign-alloc '(:struct io_uring)) :accessor ring)
   (flags :initarg :flags :initform 0 :accessor flags)
   (params :accessor params)
   (entries :initarg :entries :initform (error "You must supply the ring size") :accessor entries)))

(defun zeroed-foreign-alloc (type &key (count 1) (fill-value 0))
  (static-vectors:fill-foreign-memory
   (cffi:foreign-alloc type :count count)
   (* count (cffi:foreign-type-size type))
   fill-value))

(defmethod initialize-instance :after ((ring ring) &key)
  (let ((params (zeroed-foreign-alloc '(:struct io_uring_params))))
    (setf (cffi:foreign-slot-value params '(:struct io_uring_params) 'flags) (flags ring))
    (setf (params ring) params)
    (io_uring_queue_init_params (entries ring) (ring ring) params)
    (let ((cring (ring ring)))
      (trivial-garbage:finalize ring
                                (lambda ()
                                  (io_uring_queue_exit cring)
                                  (cffi:foreign-free params)
                                  (cffi:foreign-free cring))))))

(defmethod read-file ((ring ring) (path string) &key (directory +at-fdcwd+))
  ;; TODO if directory is passed to us, get an fd on that
  (let* ((sqe (io_uring_get_sqe (ring ring)))
         (cqe (zeroed-foreign-alloc '(:struct io_uring_cqe)))
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
        (osicat-posix:close fd)))
    buf))

(defmethod acquire-sqe ((ring ring) &key (wait-if-empty nil))
  (let ((sqe (io_uring_get_sqe (ring ring))))
    (when (cffi:null-pointer-p sqe)
      (format t "Null pointer retrieving sqe~%")
      (error "Null pointer retrieving sqe~%"))
    sqe))

(defmethod readv-file ((ring ring) (path string) &key (block-size 1024))
  (let* ((lisp-ring ring)
         (ring (ring ring))
         (cqe (zeroed-foreign-alloc '(:struct io_uring_cqe)))
         (size (osicat-posix:stat-size (osicat-posix:stat path)))
         (bytes-remaining size)
         (fd (osicat-posix:open path osicat-posix:o-rdonly))
         (required-blocks (+ (floor size block-size) (if (zerop (mod size block-size))
                                                         0 1)))
         ;; TODO: readv (and friends) only allow iovecs of len
         ;; osicat-posix::iov-max, so we need to chunk up the readvs.  We would
         ;; essentially submit N sqes rather than yeet them all
         ;; together in a single submission, then use io-uring linking
         ;; to retrieve them.
         (sqe-chunks (ceiling required-blocks osicat-posix::iov-max))
         (buf (cffi:make-shareable-byte-vector size)))
    (cffi:with-foreign-object (iovecs '(:struct iovec) required-blocks)
      (cffi:with-pointer-to-vector-data (buf buf)
        (let ((blocks-remaining required-blocks)
              (chunks-handled 0))
          (dotimes (sqe-chunk sqe-chunks)
            (let ((starting-ptr (cffi:mem-aptr iovecs '(:struct iovec) chunks-handled))
                  (next-chunk-size (min osicat-posix::iov-max blocks-remaining)))
              (dotimes (i next-chunk-size)
                (let ((ptr (cffi:mem-aptr iovecs '(:struct iovec) chunks-handled))
                      (bytes-to-read (min bytes-remaining block-size)))
                  (decf bytes-remaining bytes-to-read)
                  (setf (iovec-len ptr) bytes-to-read)
                  (setf (iovec-base ptr) (cffi:inc-pointer buf (* i block-size)))
                  (incf chunks-handled)))
              (let ((sqe (acquire-sqe lisp-ring)))
                (io_uring_prep_readv sqe fd starting-ptr next-chunk-size 0))))))
      (io_uring_submit ring)
      (dotimes (i sqe-chunks)
        (let ((wait (io_uring_wait_cqe ring cqe)))
          (when (< wait 0)
            (error "Error waiting for completion"))
          (when (< (cffi:foreign-slot-value cqe '(:struct io_uring_cqe) 'res) 0)
            (error "Async readv failed"))
          (io_uring_cqe_seen ring cqe)))
        (osicat-posix:close fd)
        (cffi:foreign-free cqe))
      buf))
