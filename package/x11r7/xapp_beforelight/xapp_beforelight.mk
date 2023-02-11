################################################################################
#
# xapp_beforelight
#
################################################################################

XAPP_BEFORELIGHT_VERSION = 1.0.6
XAPP_BEFORELIGHT_SOURCE = beforelight-$(XAPP_BEFORELIGHT_VERSION).tar.xz
XAPP_BEFORELIGHT_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_BEFORELIGHT_LICENSE = MIT
XAPP_BEFORELIGHT_LICENSE_FILES = COPYING
XAPP_BEFORELIGHT_DEPENDENCIES = xlib_libX11 xlib_libXScrnSaver xlib_libXaw xlib_libXt
XAPP_BEFORELIGHT_CONF_OPTS = --with-appdefaultdir=/usr/share/X11/app-defaults

$(eval $(autotools-package))
