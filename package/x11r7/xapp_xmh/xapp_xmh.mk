################################################################################
#
# xapp_xmh
#
################################################################################

XAPP_XMH_VERSION = 1.0.4
XAPP_XMH_SOURCE = xmh-$(XAPP_XMH_VERSION).tar.xz
XAPP_XMH_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XMH_LICENSE = MIT
XAPP_XMH_LICENSE_FILES = COPYING
XAPP_XMH_DEPENDENCIES = xlib_libXaw xdata_xbitmaps

$(eval $(autotools-package))
