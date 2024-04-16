################################################################################
#
# xapp_xkbprint
#
################################################################################

XAPP_XKBPRINT_VERSION = 1.0.6
XAPP_XKBPRINT_SOURCE = xkbprint-$(XAPP_XKBPRINT_VERSION).tar.xz
XAPP_XKBPRINT_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XKBPRINT_LICENSE = MIT
XAPP_XKBPRINT_LICENSE_FILES = COPYING
XAPP_XKBPRINT_DEPENDENCIES = xlib_libxkbfile

$(eval $(autotools-package))
