################################################################################
#
# xapp_xmessage
#
################################################################################

XAPP_XMESSAGE_VERSION = 1.0.6
XAPP_XMESSAGE_SOURCE = xmessage-$(XAPP_XMESSAGE_VERSION).tar.xz
XAPP_XMESSAGE_SITE = https://xorg.freedesktop.org/releases/individual/app
XAPP_XMESSAGE_LICENSE = MIT
XAPP_XMESSAGE_LICENSE_FILES = COPYING
XAPP_XMESSAGE_DEPENDENCIES = xlib_libXaw
XAPP_XMESSAGE_CONF_OPTS = --with-appdefaultdir=/usr/share/X11/app-defaults

$(eval $(autotools-package))
