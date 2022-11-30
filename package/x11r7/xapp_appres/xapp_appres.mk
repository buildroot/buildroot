################################################################################
#
# xapp_appres
#
################################################################################

XAPP_APPRES_VERSION = 1.0.6
XAPP_APPRES_SOURCE = appres-$(XAPP_APPRES_VERSION).tar.xz
XAPP_APPRES_SITE = http://xorg.freedesktop.org/releases/individual/app
XAPP_APPRES_LICENSE = MIT
XAPP_APPRES_LICENSE_FILES = COPYING
XAPP_APPRES_DEPENDENCIES = xlib_libX11 xlib_libXt

$(eval $(autotools-package))
