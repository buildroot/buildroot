################################################################################
#
# ledmon
#
################################################################################

LEDMON_VERSION = 0.97
LEDMON_SITE = $(call github,intel,ledmon,v$(LEDMON_VERSION))
LEDMON_DEPENDENCIES = host-pkgconf pciutils sg3_utils udev
# The code base also include a COPYING.LIB file with the LGPL-2.1 text,
# and some source files are published under LGPL-2.1, but all of them are
# at some point linked with GPL-2.0 code, making the resulting binaries
# GPL-2.0 licensed
LEDMON_LICENSE = GPL-2.0
LEDMON_LICENSE_FILES = COPYING
# 0002-Fix-unknown-type-name-ssize_t-error.patch
LEDMON_AUTORECONF = YES

$(eval $(autotools-package))
