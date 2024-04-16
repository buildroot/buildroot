################################################################################
#
# xlib_libXrender
#
################################################################################

XLIB_LIBXRENDER_VERSION = 0.9.11
XLIB_LIBXRENDER_SOURCE = libXrender-$(XLIB_LIBXRENDER_VERSION).tar.xz
XLIB_LIBXRENDER_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXRENDER_LICENSE = MIT
XLIB_LIBXRENDER_LICENSE_FILES = COPYING
XLIB_LIBXRENDER_CPE_ID_VENDOR = x.org
XLIB_LIBXRENDER_CPE_ID_PRODUCT = libxrender
XLIB_LIBXRENDER_INSTALL_STAGING = YES
XLIB_LIBXRENDER_DEPENDENCIES = xlib_libX11 xorgproto
HOST_XLIB_LIBXRENDER_DEPENDENCIES = \
	host-xlib_libX11 host-xorgproto

XLIB_LIBXRENDER_CONF_OPTS = --disable-malloc0returnsnull

$(eval $(autotools-package))
$(eval $(host-autotools-package))
