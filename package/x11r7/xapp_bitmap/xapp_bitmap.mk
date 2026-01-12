################################################################################
#
# xapp_bitmap
#
################################################################################

XAPP_BITMAP_VERSION = 1.1.1
XAPP_BITMAP_SOURCE = bitmap-$(XAPP_BITMAP_VERSION).tar.xz
XAPP_BITMAP_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_BITMAP_LICENSE = MIT
XAPP_BITMAP_LICENSE_FILES = COPYING
XAPP_BITMAP_DEPENDENCIES = xlib_libX11 xlib_libXaw xlib_libXmu xdata_xbitmaps
XAPP_BITMAP_CONF_OPTS = --with-appdefaultdir=/usr/share/X11/app-defaults

$(eval $(autotools-package))
