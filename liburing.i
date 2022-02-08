#define __attribute__(x)

%typemap(cin)   __u64     ":unsigned-long-long"
%typemap(cin)   bool      ":bool"
%typemap(cin)   int64_t   ":int64-t"
%typemap(cin)   mode_t    ":unsigned-int"
%typemap(cin)   off_t     ":unsigned-int";
%typemap(cin)   size_t    ":size-t";
%typemap(cin)   socklen_t ":socklen-t"
%typemap(cin)   ssize_t   ":int";
%typemap(cout)  bool      ":bool"

%insert("lisphead") %{
(in-package #:cl-iouring)
(cffi:defctype :u64 :unsigned-long-long)
(cffi:defctype :size-t :unsigned-long)
(cffi:defctype :int64-t :int64)
(cffi:defctype :socklen-t :unsigned-int)
%}

%insert("swiggrovel") %{
(include "sys/types.h")
(include "inttypes.h")
(include "liburing.h")
(in-package #:cl-iouring)
%}

%include "/usr/include/liburing.h"
%include "/usr/include/liburing/io_uring.h"
