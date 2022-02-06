all:
	swig -cffi -module ffi -outdir . liburing.i
