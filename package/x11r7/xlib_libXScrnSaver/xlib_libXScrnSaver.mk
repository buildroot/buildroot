################################################################################
#
# xlib_libXScrnSaver
#
################################################################################

XLIB_LIBXSCRNSAVER_VERSION = 1.2.4
XLIB_LIBXSCRNSAVER_SOURCE = libXScrnSaver-$(XLIB_LIBXSCRNSAVER_VERSION).tar.xz
XLIB_LIBXSCRNSAVER_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXSCRNSAVER_LICENSE = MIT
XLIB_LIBXSCRNSAVER_LICENSE_FILES = COPYING
XLIB_LIBXSCRNSAVER_INSTALL_STAGING = YES
XLIB_LIBXSCRNSAVER_DEPENDENCIES = xlib_libX11 xlib_libXext xorgproto
XLIB_LIBXSCRNSAVER_CONF_OPTS = --disable-malloc0returnsnull

$(eval $(autotools-package))
