################################################################################
#
# xapp_rgb
#
################################################################################

XAPP_RGB_VERSION = 1.1.0
XAPP_RGB_SOURCE = rgb-$(XAPP_RGB_VERSION).tar.xz
XAPP_RGB_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_RGB_LICENSE = MIT
XAPP_RGB_LICENSE_FILES = COPYING
XAPP_RGB_DEPENDENCIES = xorgproto host-pkgconf

$(eval $(autotools-package))
