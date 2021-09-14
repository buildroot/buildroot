################################################################################
#
# xapp_xeyes
#
################################################################################

XAPP_XEYES_VERSION = 1.2.0
XAPP_XEYES_SOURCE = xeyes-$(XAPP_XEYES_VERSION).tar.bz2
XAPP_XEYES_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XEYES_LICENSE = MIT
XAPP_XEYES_LICENSE_FILES = COPYING
XAPP_XEYES_DEPENDENCIES = xlib_libX11 xlib_libXext xlib_libXmu xlib_libXt

ifeq ($(BR2_PACKAGE_XLIB_LIBXRENDER),y)
XAPP_XEYES_DEPENDENCIES += xlib_libXrender
XAPP_XEYES_CONF_OPTS += --with-xrender
else
XAPP_XEYES_CONF_OPTS += --without-xrender
endif

$(eval $(autotools-package))
