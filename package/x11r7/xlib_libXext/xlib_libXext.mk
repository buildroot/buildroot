################################################################################
#
# xlib_libXext
#
################################################################################

XLIB_LIBXEXT_VERSION = 1.3.5
XLIB_LIBXEXT_SOURCE = libXext-$(XLIB_LIBXEXT_VERSION).tar.xz
XLIB_LIBXEXT_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXEXT_LICENSE = MIT
XLIB_LIBXEXT_LICENSE_FILES = COPYING
XLIB_LIBXEXT_CPE_ID_VENDOR = x
XLIB_LIBXEXT_CPE_ID_PRODUCT = libxext
XLIB_LIBXEXT_INSTALL_STAGING = YES
XLIB_LIBXEXT_DEPENDENCIES = xlib_libX11 xorgproto
XLIB_LIBXEXT_CONF_OPTS = --disable-malloc0returnsnull

$(eval $(autotools-package))
