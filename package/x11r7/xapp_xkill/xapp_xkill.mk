################################################################################
#
# xapp_xkill
#
################################################################################

XAPP_XKILL_VERSION = 1.0.6
XAPP_XKILL_SOURCE = xkill-$(XAPP_XKILL_VERSION).tar.xz
XAPP_XKILL_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XKILL_LICENSE = MIT
XAPP_XKILL_LICENSE_FILES = COPYING
XAPP_XKILL_DEPENDENCIES = xlib_libX11 xlib_libXmu

$(eval $(autotools-package))
