################################################################################
#
# xapp_editres
#
################################################################################

XAPP_EDITRES_VERSION = 1.0.9
XAPP_EDITRES_SOURCE = editres-$(XAPP_EDITRES_VERSION).tar.xz
XAPP_EDITRES_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_EDITRES_LICENSE = MIT
XAPP_EDITRES_LICENSE_FILES = COPYING
XAPP_EDITRES_DEPENDENCIES = xlib_libX11 xlib_libXaw xlib_libXmu xlib_libXt
XAPP_EDITRES_CONF_OPTS = --with-appdefaultdir=/usr/share/X11/app-defaults

ifeq ($(BR2_PACKAGE_XLIB_LIBXKBFILE),y)
XAPP_EDITRES_CONF_OPTS += --with-xkb
XAPP_EDITRES_DEPENDENCIES += xlib_libxkbfile
else
XAPP_EDITRES_CONF_OPTS += --without-xkb
endif

$(eval $(autotools-package))
