(in-package #:iouring-sys)

(include
 "errno.h"
 "fcntl.h"
 "limits.h"
 "signal.h"
 "stdlib.h"
 "sys/stat.h"
 "sys/types.h"
 "sys/uio.h"
 "time.h"
 "unistd.h"
 "utime.h")

(ctype size "size_t")
(ctype ssize "ssize_t")
(ctype pid "pid_t")
(ctype off "off_t")
(ctype mode "mode_t")

(cstruct iovec "struct iovec"
  (base "iov_base" :type (:pointer :void))
  (len  "iov_len"  :type size))

(constant (iov-max #+linux "UIO_MAXIOV"))
