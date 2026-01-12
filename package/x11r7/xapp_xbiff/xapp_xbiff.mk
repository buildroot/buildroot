################################################################################
#
# xapp_xbiff
#
################################################################################

XAPP_XBIFF_VERSION = 1.0.5
XAPP_XBIFF_SOURCE = xbiff-$(XAPP_XBIFF_VERSION).tar.xz
XAPP_XBIFF_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XBIFF_LICENSE = MIT
XAPP_XBIFF_LICENSE_FILES = COPYING
XAPP_XBIFF_DEPENDENCIES = xlib_libXaw xdata_xbitmaps

$(eval $(autotools-package))
