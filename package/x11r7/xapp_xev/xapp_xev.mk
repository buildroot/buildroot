################################################################################
#
# xapp_xev
#
################################################################################

XAPP_XEV_VERSION = 1.2.5
XAPP_XEV_SOURCE = xev-$(XAPP_XEV_VERSION).tar.xz
XAPP_XEV_SITE = https://xorg.freedesktop.org/releases/individual/app
XAPP_XEV_LICENSE = MIT
XAPP_XEV_LICENSE_FILES = COPYING
XAPP_XEV_DEPENDENCIES = xlib_libX11 xlib_libXrandr

$(eval $(autotools-package))
