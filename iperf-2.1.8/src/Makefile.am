bin_PROGRAMS = iperf

LIBCOMPAT_LDADDS = @STRIP_BEGIN@ \
		   $(top_builddir)/compat/libcompat.a \
		   @STRIP_END@

AM_CPPFLAGS = @STRIP_BEGIN@ \
	      -I$(top_srcdir)/include \
	      -I$(top_builddir)/include \
	      @STRIP_END@

AM_CXXFLAGS = -Wall
AM_CFLAGS = -Wall

if DEBUG_SYMBOLS
AM_CFLAGS += -g3 -O0
AM_CXXFLAGS += -g3 -O0
else
AM_CFLAGS += -O2
AM_CXXFLAGS += -O2
endif


iperf_LDFLAGS = @CFLAGS@ @PTHREAD_CFLAGS@ @WEB100_CFLAGS@ @DEFS@

iperf_SOURCES = \
		Client.cpp \
		Extractor.c \
	        isochronous.cpp \
		Launch.cpp \
		active_hosts.cpp \
		Listener.cpp \
		Locale.c \
		PerfSocket.cpp \
		Reporter.c \
		Reports.c \
		ReportOutputs.c \
		Server.cpp \
		Settings.cpp \
		SocketAddr.c \
		gnu_getopt.c \
		gnu_getopt_long.c \
	        histogram.c \
		main.cpp \
		service.c \
		socket_io.c \
		stdio.c \
		packet_ring.c \
		tcp_window_size.c \
		pdfs.c \
		dscp.c
iperf_LDADD = $(LIBCOMPAT_LDADDS)


if CHECKPROGRAMS
noinst_PROGRAMS = checkdelay checkpdfs checkisoch igmp_querier
checkdelay_SOURCES = checkdelay.c
checkdelay_LDADD = $(LIBCOMPAT_LDADDS)
checkpdfs_SOURCES = pdfs.c checkpdfs.c stdio.c
checkpdfs_LDADD = -lm
checkisoch_SOURCES = checkisoch.cpp isochronous.cpp pdfs.c stdio.c
igmp_querier_SOURCES = igmp_querier.c
checkisoch_LDADD = $(LIBCOMPAT_LDADDS)
endif


if AF_PACKET
iperf_SOURCES += checksums.c
endif

