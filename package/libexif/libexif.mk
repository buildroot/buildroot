################################################################################
#
# libexif
#
################################################################################

LIBEXIF_VERSION = 0.6.24
LIBEXIF_SOURCE = libexif-$(LIBEXIF_VERSION).tar.bz2
LIBEXIF_SITE = \
	https://github.com/libexif/libexif/releases/download/v$(LIBEXIF_VERSION)
LIBEXIF_INSTALL_STAGING = YES
LIBEXIF_DEPENDENCIES = host-pkgconf
LIBEXIF_LICENSE = LGPL-2.1+
LIBEXIF_LICENSE_FILES = COPYING
LIBEXIF_CPE_ID_VALID = YES

$(eval $(autotools-package))
