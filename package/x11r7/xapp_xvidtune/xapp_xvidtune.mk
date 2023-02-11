################################################################################
#
# xapp_xvidtune
#
################################################################################

XAPP_XVIDTUNE_VERSION = 1.0.4
XAPP_XVIDTUNE_SOURCE = xvidtune-$(XAPP_XVIDTUNE_VERSION).tar.xz
XAPP_XVIDTUNE_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XVIDTUNE_LICENSE = MIT
XAPP_XVIDTUNE_LICENSE_FILES = COPYING
XAPP_XVIDTUNE_DEPENDENCIES = xlib_libXaw xlib_libXxf86vm

$(eval $(autotools-package))
