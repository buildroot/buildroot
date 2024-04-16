################################################################################
#
# xapp_xdriinfo
#
################################################################################

XAPP_XDRIINFO_VERSION = 1.0.7
XAPP_XDRIINFO_SOURCE = xdriinfo-$(XAPP_XDRIINFO_VERSION).tar.xz
XAPP_XDRIINFO_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XDRIINFO_LICENSE = MIT
XAPP_XDRIINFO_LICENSE_FILES = COPYING
XAPP_XDRIINFO_DEPENDENCIES = libgl xlib_libX11 xorgproto

$(eval $(autotools-package))
