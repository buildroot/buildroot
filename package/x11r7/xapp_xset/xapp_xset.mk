################################################################################
#
# xapp_xset
#
################################################################################

XAPP_XSET_VERSION = 1.2.5
XAPP_XSET_SOURCE = xset-$(XAPP_XSET_VERSION).tar.xz
XAPP_XSET_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XSET_LICENSE = MIT
XAPP_XSET_LICENSE_FILES = COPYING
XAPP_XSET_DEPENDENCIES = xlib_libXmu

$(eval $(autotools-package))
