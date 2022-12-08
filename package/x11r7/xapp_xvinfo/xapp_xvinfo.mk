################################################################################
#
# xapp_xvinfo
#
################################################################################

XAPP_XVINFO_VERSION = 1.1.5
XAPP_XVINFO_SOURCE = xvinfo-$(XAPP_XVINFO_VERSION).tar.xz
XAPP_XVINFO_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XVINFO_LICENSE = MIT
XAPP_XVINFO_LICENSE_FILES = COPYING
XAPP_XVINFO_DEPENDENCIES = xlib_libX11 xlib_libXv

$(eval $(autotools-package))
