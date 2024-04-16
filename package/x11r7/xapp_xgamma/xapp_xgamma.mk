################################################################################
#
# xapp_xgamma
#
################################################################################

XAPP_XGAMMA_VERSION = 1.0.7
XAPP_XGAMMA_SOURCE = xgamma-$(XAPP_XGAMMA_VERSION).tar.xz
XAPP_XGAMMA_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XGAMMA_LICENSE = MIT
XAPP_XGAMMA_LICENSE_FILES = COPYING
XAPP_XGAMMA_DEPENDENCIES = xlib_libXxf86vm

$(eval $(autotools-package))
