################################################################################
#
# xapp_xwininfo
#
################################################################################

XAPP_XWININFO_VERSION = 1.1.6
XAPP_XWININFO_SOURCE = xwininfo-$(XAPP_XWININFO_VERSION).tar.xz
XAPP_XWININFO_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XWININFO_LICENSE = MIT
XAPP_XWININFO_LICENSE_FILES = COPYING
XAPP_XWININFO_DEPENDENCIES = xlib_libX11 xlib_libXmu

$(eval $(autotools-package))
