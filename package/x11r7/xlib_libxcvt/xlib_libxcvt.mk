################################################################################
#
# xlib_libxcvt
#
################################################################################

XLIB_LIBXCVT_VERSION = 0.1.2
XLIB_LIBXCVT_SOURCE = libxcvt-$(XLIB_LIBXCVT_VERSION).tar.xz
XLIB_LIBXCVT_SITE = https://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXCVT_LICENSE = MIT
XLIB_LIBXCVT_LICENSE_FILES = COPYING
XLIB_LIBXCVT_INSTALL_STAGING = YES

$(eval $(meson-package))
