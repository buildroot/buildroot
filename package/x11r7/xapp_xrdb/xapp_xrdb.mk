################################################################################
#
# xapp_xrdb
#
################################################################################

XAPP_XRDB_VERSION = 1.2.2
XAPP_XRDB_SOURCE = xrdb-$(XAPP_XRDB_VERSION).tar.xz
XAPP_XRDB_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XRDB_LICENSE = MIT
XAPP_XRDB_LICENSE_FILES = COPYING
XAPP_XRDB_DEPENDENCIES = xlib_libX11 xlib_libXmu

$(eval $(autotools-package))
