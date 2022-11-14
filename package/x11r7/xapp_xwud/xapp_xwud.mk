################################################################################
#
# xapp_xwud
#
################################################################################

XAPP_XWUD_VERSION = 1.0.6
XAPP_XWUD_SOURCE = xwud-$(XAPP_XWUD_VERSION).tar.xz
XAPP_XWUD_SITE = https://xorg.freedesktop.org/releases/individual/app
XAPP_XWUD_LICENSE = MIT
XAPP_XWUD_LICENSE_FILES = COPYING
XAPP_XWUD_DEPENDENCIES = xlib_libX11

$(eval $(autotools-package))
