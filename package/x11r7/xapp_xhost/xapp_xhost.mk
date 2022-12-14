################################################################################
#
# xapp_xhost
#
################################################################################

XAPP_XHOST_VERSION = 1.0.9
XAPP_XHOST_SOURCE = xhost-$(XAPP_XHOST_VERSION).tar.xz
XAPP_XHOST_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XHOST_LICENSE = MIT
XAPP_XHOST_LICENSE_FILES = COPYING
XAPP_XHOST_DEPENDENCIES = xlib_libX11 xlib_libXmu $(TARGET_NLS_DEPENDENCIES)
XAPP_XHOST_CONF_ENV = LIBS=$(TARGET_NLS_LIBS)

$(eval $(autotools-package))
