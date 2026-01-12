################################################################################
#
# xapp_xsm
#
################################################################################

XAPP_XSM_VERSION = 1.0.6
XAPP_XSM_SOURCE = xsm-$(XAPP_XSM_VERSION).tar.xz
XAPP_XSM_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XSM_LICENSE = MIT
XAPP_XSM_LICENSE_FILES = COPYING
XAPP_XSM_DEPENDENCIES = xlib_libXaw

$(eval $(autotools-package))
