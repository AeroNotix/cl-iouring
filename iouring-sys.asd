(defsystem #:iouring-sys
  :serial t
  :defsystem-depends-on (#:cffi-grovel)
  :depends-on (#:cffi)
  :components ((:file "sys")
               (:cffi-grovel-file "uio")
               (:file "uio-wrap")))
