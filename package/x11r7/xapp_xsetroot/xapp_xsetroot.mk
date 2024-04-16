################################################################################
#
# xapp_xsetroot
#
################################################################################

XAPP_XSETROOT_VERSION = 1.1.3
XAPP_XSETROOT_SOURCE = xsetroot-$(XAPP_XSETROOT_VERSION).tar.xz
XAPP_XSETROOT_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XSETROOT_LICENSE = MIT
XAPP_XSETROOT_LICENSE_FILES = COPYING
XAPP_XSETROOT_DEPENDENCIES = xlib_libX11 xlib_libXmu xlib_libXcursor xdata_xbitmaps

$(eval $(autotools-package))
