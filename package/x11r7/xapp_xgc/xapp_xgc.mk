################################################################################
#
# xapp_xgc
#
################################################################################

XAPP_XGC_VERSION = 1.0.6
XAPP_XGC_SOURCE = xgc-$(XAPP_XGC_VERSION).tar.xz
XAPP_XGC_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XGC_LICENSE = MIT
XAPP_XGC_LICENSE_FILES = COPYING
XAPP_XGC_DEPENDENCIES = xlib_libXaw

$(eval $(autotools-package))
