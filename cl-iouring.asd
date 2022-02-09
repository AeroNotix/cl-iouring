(defsystem #:cl-iouring
  :defsystem-depends-on (#:cffi-grovel)
  :depends-on (#:cffi #:trivial-garbage #:osicat)
  :serial t
  :components ((:file "package")
               (:file "ffi")
               (:cffi-grovel-file "grovel")
               (:cffi-wrapper-file "ffi-grovel")
               (:file "wrap")))
