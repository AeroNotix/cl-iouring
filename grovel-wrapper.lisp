(include "sys/types.h")
(include "liburing.h")

(in-package :cl-iouring)

(defwrapper ("io_uring_prep_openat" io_uring_prep_openat) :void
  (seq :pointer)
  (dfd :int)
  (path :string)
  (flags :int)
  (mode :int))
