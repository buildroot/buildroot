AUTOMAKE_OPTIONS = foreign
SUBDIRS = compat doc include src man

AM_CPPFLAGS = @STRIP_BEGIN@ \
	      -I$(top_srcdir)/include \
	      -I$(top_builddir)/include \
	      @STRIP_END@

AM_CXXFLAGS = -Wall
AM_FLAGS = -Wall

EXTRA_DIST = t
TEST_EXTENSIONS = .sh
TESTS = t/t1_tcp.sh t/t2_tcp6.sh t/t3_udp.sh t/t4_udp6.sh \
	t/t5_f.sh t/t6_filelong.sh t/t7_n.sh t/t8_num.sh \
	t/t9_parallel.sh t/t10_dualtest.sh t/t11_tradeoff.sh \
	t/t12_full_duplex.sh t/t13_reverse.sh

