noinst_LIBRARIES = libcompat.a

AM_CPPFLAGS = @STRIP_BEGIN@ \
	      -I$(top_srcdir)/include \
	      -I$(top_builddir)/include \
	      @STRIP_END@

AM_CXXFLAGS = -Wall
AM_CFLAGS = -Wall
AM_LDFLAGS = -lrt

libcompat_a_SOURCES = \
		      Thread.c \
		      error.c \
		      delay.c \
		      gettimeofday.c \
		      gettcpinfo.c \
		      inet_ntop.c \
		      inet_pton.c \
		      signal.c \
		      snprintf.c \
		      string.c
