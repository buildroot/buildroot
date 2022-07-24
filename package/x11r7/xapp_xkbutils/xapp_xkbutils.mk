################################################################################
#
# xapp_xkbutils
#
################################################################################

XAPP_XKBUTILS_VERSION = 1.0.5
XAPP_XKBUTILS_SOURCE = xkbutils-$(XAPP_XKBUTILS_VERSION).tar.xz
XAPP_XKBUTILS_SITE = https://xorg.freedesktop.org/releases/individual/app
XAPP_XKBUTILS_LICENSE = MIT
XAPP_XKBUTILS_LICENSE_FILES = COPYING
XAPP_XKBUTILS_DEPENDENCIES = xlib_libXaw xlib_libxkbfile

$(eval $(autotools-package))
