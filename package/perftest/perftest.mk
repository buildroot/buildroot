################################################################################
#
# perftest
#
################################################################################

PERFTEST_VERSION = 24.07.0-0.44
PERFTEST_SITE = $(call github,linux-rdma,perftest,$(PERFTEST_VERSION))
PERFTEST_LICENSE = GPL-2.0 or BSD-2-Clause
PERFTEST_LICENSE_FILES = COPYING
PERFTEST_DEPENDENCIES = pciutils rdma-core
# Fetched from Github, with no configure script
PERFTEST_AUTORECONF = YES

$(eval $(autotools-package))
