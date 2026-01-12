################################################################################
#
# xapp_xpr
#
################################################################################

XAPP_XPR_VERSION = 1.2.0
XAPP_XPR_SOURCE = xpr-$(XAPP_XPR_VERSION).tar.xz
XAPP_XPR_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XPR_LICENSE = MIT
XAPP_XPR_LICENSE_FILES = COPYING
XAPP_XPR_DEPENDENCIES = xlib_libX11 xlib_libXmu

$(eval $(autotools-package))
