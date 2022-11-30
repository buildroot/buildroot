################################################################################
#
# xapp_xmodmap
#
################################################################################

XAPP_XMODMAP_VERSION = 1.0.11
XAPP_XMODMAP_SOURCE = xmodmap-$(XAPP_XMODMAP_VERSION).tar.xz
XAPP_XMODMAP_SITE = https://xorg.freedesktop.org/releases/individual/app
XAPP_XMODMAP_LICENSE = MIT
XAPP_XMODMAP_LICENSE_FILES = COPYING
XAPP_XMODMAP_DEPENDENCIES = xlib_libX11

$(eval $(autotools-package))
