################################################################################
#
# xapp_xmag
#
################################################################################

XAPP_XMAG_VERSION = 1.0.7
XAPP_XMAG_SOURCE = xmag-$(XAPP_XMAG_VERSION).tar.xz
XAPP_XMAG_SITE = https://xorg.freedesktop.org/releases/individual/app
XAPP_XMAG_LICENSE = MIT
XAPP_XMAG_LICENSE_FILES = COPYING
XAPP_XMAG_DEPENDENCIES = xlib_libXaw
XAPP_XMAG_CONF_OPTS = --with-appdefaultdir=/usr/share/X11/app-defaults

$(eval $(autotools-package))
