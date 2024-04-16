################################################################################
#
# xapp_xstdcmap
#
################################################################################

XAPP_XSTDCMAP_VERSION = 1.0.5
XAPP_XSTDCMAP_SOURCE = xstdcmap-$(XAPP_XSTDCMAP_VERSION).tar.xz
XAPP_XSTDCMAP_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XSTDCMAP_LICENSE = MIT
XAPP_XSTDCMAP_LICENSE_FILES = COPYING
XAPP_XSTDCMAP_DEPENDENCIES = xlib_libX11 xlib_libXmu

$(eval $(autotools-package))
