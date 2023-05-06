################################################################################
#
# xlib_libXt
#
################################################################################

XLIB_LIBXT_VERSION = 1.3.0
XLIB_LIBXT_SOURCE = libXt-$(XLIB_LIBXT_VERSION).tar.xz
XLIB_LIBXT_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXT_LICENSE = MIT
XLIB_LIBXT_LICENSE_FILES = COPYING
XLIB_LIBXT_INSTALL_STAGING = YES
XLIB_LIBXT_CPE_ID_VENDOR = x
XLIB_LIBXT_CPE_ID_PRODUCT = libxt
XLIB_LIBXT_DEPENDENCIES = xlib_libSM xlib_libX11 xorgproto xcb-proto libxcb host-xorgproto
XLIB_LIBXT_CONF_OPTS = --disable-malloc0returnsnull

$(eval $(autotools-package))
