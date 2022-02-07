%insert("lisphead") %{
(in-package #:cl-iouring)
%}

%typemap(cin) mode_t ":uint32";

%include "/usr/include/liburing.h"
