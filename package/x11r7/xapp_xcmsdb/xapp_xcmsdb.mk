################################################################################
#
# xapp_xcmsdb
#
################################################################################

XAPP_XCMSDB_VERSION = 1.0.7
XAPP_XCMSDB_SOURCE = xcmsdb-$(XAPP_XCMSDB_VERSION).tar.xz
XAPP_XCMSDB_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XCMSDB_LICENSE = MIT
XAPP_XCMSDB_LICENSE_FILES = COPYING
XAPP_XCMSDB_DEPENDENCIES = xlib_libX11

$(eval $(autotools-package))
