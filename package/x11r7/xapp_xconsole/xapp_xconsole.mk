################################################################################
#
# xapp_xconsole
#
################################################################################

XAPP_XCONSOLE_VERSION = 1.0.8
XAPP_XCONSOLE_SOURCE = xconsole-$(XAPP_XCONSOLE_VERSION).tar.xz
XAPP_XCONSOLE_SITE = https://xorg.freedesktop.org/releases/individual/app
XAPP_XCONSOLE_LICENSE = MIT
XAPP_XCONSOLE_LICENSE_FILES = COPYING
XAPP_XCONSOLE_DEPENDENCIES = \
	xlib_libX11 xlib_libXaw xlib_libXt xorgproto \
	xlib_libXmu
XAPP_XCONSOLE_CONF_OPTS = --with-appdefaultdir=/usr/share/X11/app-defaults

$(eval $(autotools-package))
