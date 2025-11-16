################################################################################
#
# libdvdcss
#
################################################################################

LIBDVDCSS_VERSION = 1.5.0
LIBDVDCSS_SOURCE = libdvdcss-$(LIBDVDCSS_VERSION).tar.xz
LIBDVDCSS_SITE = https://download.videolan.org/pub/videolan/libdvdcss/$(LIBDVDCSS_VERSION)
LIBDVDCSS_INSTALL_STAGING = YES
LIBDVDCSS_LICENSE = GPL-2.0+
LIBDVDCSS_LICENSE_FILES = COPYING

$(eval $(meson-package))
