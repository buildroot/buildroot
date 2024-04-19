################################################################################
#
# libusbgx
#
################################################################################

LIBUSBGX_VERSION = a5bfa81017a9b2064bc449cf74f5f9d106445f62
LIBUSBGX_SITE = $(call github,linux-usb-gadgets,libusbgx,$(LIBUSBGX_VERSION))
LIBUSBGX_LICENSE = GPL-2.0+ (examples), LGPL-2.1+ (library)
LIBUSBGX_LICENSE_FILES = COPYING COPYING.LGPL
LIBUSBGX_DEPENDENCIES = host-pkgconf libconfig
LIBUSBGX_AUTORECONF = YES
LIBUSBGX_INSTALL_STAGING = YES

$(eval $(autotools-package))
