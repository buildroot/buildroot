################################################################################
#
# atest
#
################################################################################

ATEST_VERSION = 9ff52ee5d7764984e21fe40a381b41ecd2d63548
ATEST_SITE = $(call github,amouiche,atest,$(ATEST_VERSION))
ATEST_LICENSE = GPL-2.0+
ATEST_LICENSE_FILES = COPYING
ATEST_DEPENDENCIES = host-pkgconf libev alsa-lib
# Fetched from Github, with no configure script
ATEST_AUTORECONF = YES

$(eval $(autotools-package))
