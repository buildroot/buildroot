################################################################################
#
# xapp_xlsatoms
#
################################################################################

XAPP_XLSATOMS_VERSION = 1.1.4
XAPP_XLSATOMS_SOURCE = xlsatoms-$(XAPP_XLSATOMS_VERSION).tar.xz
XAPP_XLSATOMS_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XLSATOMS_LICENSE = MIT
XAPP_XLSATOMS_LICENSE_FILES = COPYING
XAPP_XLSATOMS_DEPENDENCIES = xlib_libX11 xlib_libXmu

$(eval $(autotools-package))
