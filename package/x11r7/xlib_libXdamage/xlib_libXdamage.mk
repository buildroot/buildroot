################################################################################
#
# xlib_libXdamage
#
################################################################################

XLIB_LIBXDAMAGE_VERSION = 1.1.6
XLIB_LIBXDAMAGE_SOURCE = libXdamage-$(XLIB_LIBXDAMAGE_VERSION).tar.xz
XLIB_LIBXDAMAGE_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXDAMAGE_LICENSE = MIT
XLIB_LIBXDAMAGE_LICENSE_FILES = COPYING
XLIB_LIBXDAMAGE_INSTALL_STAGING = YES
XLIB_LIBXDAMAGE_DEPENDENCIES = xlib_libX11 xlib_libXfixes xorgproto

$(eval $(autotools-package))
