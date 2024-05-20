################################################################################
#
# mokutil
#
################################################################################

MOKUTIL_VERSION = 0.7.2
MOKUTIL_SITE = $(call github,lcp,mokutil,$(MOKUTIL_VERSION))
MOKUTIL_LICENSE = GPL-3.0+
MOKUTIL_LICENSE_FILES = COPYING
MOKUTIL_AUTORECONF = YES

MOKUTIL_DEPENDENCIES = \
	efivar \
	host-pkgconf \
	keyutils \
	$(if $(BR2_PACKAGE_LIBXCRYPT),libxcrypt) \
	openssl

$(eval $(autotools-package))
