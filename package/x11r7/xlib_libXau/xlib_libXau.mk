################################################################################
#
# xlib_libXau
#
################################################################################

XLIB_LIBXAU_VERSION = 1.0.12
XLIB_LIBXAU_SOURCE = libXau-$(XLIB_LIBXAU_VERSION).tar.xz
XLIB_LIBXAU_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXAU_LICENSE = MIT
XLIB_LIBXAU_LICENSE_FILES = COPYING
XLIB_LIBXAU_INSTALL_STAGING = YES
XLIB_LIBXAU_DEPENDENCIES = host-pkgconf xutil_util-macros xorgproto
HOST_XLIB_LIBXAU_DEPENDENCIES = \
	host-pkgconf host-xutil_util-macros host-xorgproto

$(eval $(autotools-package))
$(eval $(host-autotools-package))
