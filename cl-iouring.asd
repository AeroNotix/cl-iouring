(defsystem #:cl-iouring
  :defsystem-depends-on (#:cffi-grovel)
  :depends-on (#:cffi #:cffi-helpers #:trivial-garbage)
  :serial t
  :components ((:file "package")
               (:cffi-grovel-file "grovel")
               (:cffi-wrapper-file "grovel-wrapper")
               (:file "wrap")
               (:file "ffi")))
