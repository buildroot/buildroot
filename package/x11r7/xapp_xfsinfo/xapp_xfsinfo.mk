################################################################################
#
# xapp_xfsinfo
#
################################################################################

XAPP_XFSINFO_VERSION = 1.0.7
XAPP_XFSINFO_SOURCE = xfsinfo-$(XAPP_XFSINFO_VERSION).tar.xz
XAPP_XFSINFO_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XFSINFO_LICENSE = MIT
XAPP_XFSINFO_LICENSE_FILES = COPYING
XAPP_XFSINFO_DEPENDENCIES = xlib_libFS xlib_libX11

$(eval $(autotools-package))
