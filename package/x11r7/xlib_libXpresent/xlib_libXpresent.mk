################################################################################
#
# xlib_libXpresent
#
################################################################################

XLIB_LIBXPRESENT_VERSION = 1.0.1
XLIB_LIBXPRESENT_SOURCE = libXpresent-$(XLIB_LIBXPRESENT_VERSION).tar.xz
XLIB_LIBXPRESENT_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXPRESENT_LICENSE = MIT
XLIB_LIBXPRESENT_LICENSE_FILES = COPYING
XLIB_LIBXPRESENT_INSTALL_STAGING = YES

XLIB_LIBXPRESENT_DEPENDENCIES = \
	xlib_libX11 \
	xlib_libXext \
	xlib_libXfixes \
	xlib_libXrandr \
	xorgproto

$(eval $(autotools-package))
