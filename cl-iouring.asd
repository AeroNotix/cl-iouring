(defsystem #:cl-iouring
  :defsystem-depends-on (#:cffi-grovel)
  :depends-on (#:cffi #:cffi-helpers)
  :serial t
  :components ((:file "package")
               (:cffi-grovel-file "grovel")
               (:file "ffi")))
