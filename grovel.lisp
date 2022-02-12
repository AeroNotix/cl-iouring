(in-package #:iouring)

(include "fcntl.h")
(constant (+at-fdcwd+ "AT_FDCWD"))

(include "liburing.h")
(include "sys/uio.h")
(constant (+uio-maxiov+ "UIO_MAXIOV"))
