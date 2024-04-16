################################################################################
#
# xlib_libXrandr
#
################################################################################

XLIB_LIBXRANDR_VERSION = 1.5.3
XLIB_LIBXRANDR_SOURCE = libXrandr-$(XLIB_LIBXRANDR_VERSION).tar.xz
XLIB_LIBXRANDR_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXRANDR_LICENSE = MIT
XLIB_LIBXRANDR_LICENSE_FILES = COPYING
XLIB_LIBXRANDR_CPE_ID_VENDOR = x.org
XLIB_LIBXRANDR_CPE_ID_PRODUCT = libxrandr
XLIB_LIBXRANDR_INSTALL_STAGING = YES
XLIB_LIBXRANDR_DEPENDENCIES = xlib_libX11 xlib_libXext xlib_libXrender xorgproto
XLIB_LIBXRANDR_CONF_OPTS = --disable-malloc0returnsnull

$(eval $(autotools-package))
