################################################################################
#
# xapp_viewres
#
################################################################################

XAPP_VIEWRES_VERSION = 1.0.7
XAPP_VIEWRES_SOURCE = viewres-$(XAPP_VIEWRES_VERSION).tar.xz
XAPP_VIEWRES_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_VIEWRES_LICENSE = MIT
XAPP_VIEWRES_LICENSE_FILES = COPYING
XAPP_VIEWRES_DEPENDENCIES = xlib_libXaw
XAPP_VIEWRES_CONF_OPTS = --with-appdefaultdir=/usr/share/X11/app-defaults

$(eval $(autotools-package))
