swig/swig:
	cd swig && ./autogen.sh
	cd swig && ./configure
	cd swig && make -j 40

all:
	SWIG_LIB=swig/Lib/ swig/swig -cffi -module ffi -outdir . liburing.i
