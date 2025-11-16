################################################################################
#
# libdvdnav
#
################################################################################

LIBDVDNAV_VERSION = 7.0.0
LIBDVDNAV_SOURCE = libdvdnav-$(LIBDVDNAV_VERSION).tar.xz
LIBDVDNAV_SITE = https://download.videolan.org/pub/videolan/libdvdnav/$(LIBDVDNAV_VERSION)
LIBDVDNAV_INSTALL_STAGING = YES
LIBDVDNAV_DEPENDENCIES = libdvdread host-pkgconf
LIBDVDNAV_LICENSE = GPL-2.0+
LIBDVDNAV_LICENSE_FILES = COPYING

$(eval $(meson-package))
