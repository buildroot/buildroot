################################################################################
#
# libdvdread
#
################################################################################

LIBDVDREAD_VERSION = 7.0.1
LIBDVDREAD_SOURCE = libdvdread-$(LIBDVDREAD_VERSION).tar.xz
LIBDVDREAD_SITE = https://download.videolan.org/pub/videolan/libdvdread/$(LIBDVDREAD_VERSION)
LIBDVDREAD_INSTALL_STAGING = YES
LIBDVDREAD_LICENSE = GPL-2.0+
LIBDVDREAD_LICENSE_FILES = COPYING
LIBDVDREAD_CONF_OPTS = -Dlibdvdcss=enabled
LIBDVDREAD_DEPENDENCIES = libdvdcss host-pkgconf

$(eval $(meson-package))
