################################################################################
#
# ledmon
#
################################################################################

LEDMON_VERSION = 1.0.0
LEDMON_SITE = $(call github,intel,ledmon,v$(LEDMON_VERSION))
LEDMON_DEPENDENCIES = host-autoconf-archive host-pkgconf pciutils sg3_utils udev
# The code base also include a COPYING.LIB file with the LGPL-2.1 text,
# and some source files are published under LGPL-2.1, but all of them are
# at some point linked with GPL-2.0 code, making the resulting binaries
# GPL-2.0 licensed
LEDMON_LICENSE = GPL-2.0
LEDMON_LICENSE_FILES = COPYING
# From git
LEDMON_AUTORECONF = YES
LEDMON_AUTORECONF_OPTS = --include=$(HOST_DIR)/share/autoconf-archive

$(eval $(autotools-package))
