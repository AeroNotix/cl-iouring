(defpackage #:iouring
  (:use #:cl #:iouring-sys)
  (:import-from #:cffi #:defcstruct #:defcfun))

(cffi:define-foreign-library liburing
  (:unix (:or "liburing.so")))

(cffi:use-foreign-library liburing)
