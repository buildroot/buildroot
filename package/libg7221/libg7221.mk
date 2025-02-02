################################################################################
#
# libg7221
#
################################################################################

LIBG7221_VERSION = 97d7ff5cf508fb6584a43b9e0c09220f8765cb3b
# we use the FreeSwitch fork because it contains pkgconf support
LIBG7221_SITE = $(call github,freeswitch,libg7221,$(LIBG7221_VERSION))
LIBG7221_LICENSE = Polycom
LIBG7221_LICENSE_FILES = COPYING
LIBG7221_AUTORECONF = YES
LIBG7221_INSTALL_STAGING = YES

$(eval $(autotools-package))
