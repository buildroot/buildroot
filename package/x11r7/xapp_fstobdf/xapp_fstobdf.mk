################################################################################
#
# xapp_fstobdf
#
################################################################################

XAPP_FSTOBDF_VERSION = 1.0.7
XAPP_FSTOBDF_SOURCE = fstobdf-$(XAPP_FSTOBDF_VERSION).tar.xz
XAPP_FSTOBDF_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_FSTOBDF_LICENSE = MIT
XAPP_FSTOBDF_LICENSE_FILES = COPYING
XAPP_FSTOBDF_DEPENDENCIES = xlib_libFS xlib_libX11

$(eval $(autotools-package))
