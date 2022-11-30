################################################################################
#
# xapp_xclipboard
#
################################################################################

XAPP_XCLIPBOARD_VERSION = 1.1.4
XAPP_XCLIPBOARD_SOURCE = xclipboard-$(XAPP_XCLIPBOARD_VERSION).tar.xz
XAPP_XCLIPBOARD_SITE = https://xorg.freedesktop.org/releases/individual/app
XAPP_XCLIPBOARD_LICENSE = MIT
XAPP_XCLIPBOARD_LICENSE_FILES = COPYING
XAPP_XCLIPBOARD_DEPENDENCIES = xlib_libXaw xlib_libXmu xlib_libXt
XAPP_XCLIPBOARD_CONF_OPTS = --with-appdefaultdir=/usr/share/X11/app-defaults

$(eval $(autotools-package))
