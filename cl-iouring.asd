(defsystem #:cl-iouring
  :defsystem-depends-on (#:cffi-grovel)
  :depends-on (#:cffi #:cffi-helpers #:trivial-garbage)
  :serial t
  :components ((:file "package")
               (:file "ffi")
               (:cffi-grovel-file "grovel")
               (:cffi-wrapper-file "ffi-grovel")
               (:file "wrap")))
