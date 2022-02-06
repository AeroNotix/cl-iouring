(defpackage #:cl-iouring
  (:use #:cl)
  (:import-from #:cffi #:defcstruct #:defcfun))

(cffi:define-foreign-library liburing
  (:unix (:or "liburing.so")))

(cffi:use-foreign-library liburing)
