################################################################################
#
# xlib_libXinerama
#
################################################################################

XLIB_LIBXINERAMA_VERSION = 1.1.5
XLIB_LIBXINERAMA_SOURCE = libXinerama-$(XLIB_LIBXINERAMA_VERSION).tar.xz
XLIB_LIBXINERAMA_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXINERAMA_LICENSE = MIT
XLIB_LIBXINERAMA_LICENSE_FILES = COPYING
XLIB_LIBXINERAMA_CPE_ID_VENDOR = x
XLIB_LIBXINERAMA_CPE_ID_PRODUCT = libxinerama
XLIB_LIBXINERAMA_INSTALL_STAGING = YES
XLIB_LIBXINERAMA_DEPENDENCIES = xlib_libX11 xlib_libXext xorgproto
XLIB_LIBXINERAMA_CONF_OPTS = --disable-malloc0returnsnull

$(eval $(autotools-package))
