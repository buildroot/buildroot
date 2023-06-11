################################################################################
#
# xapp_setxkbmap
#
################################################################################

XAPP_SETXKBMAP_VERSION = 1.3.4
XAPP_SETXKBMAP_SOURCE = setxkbmap-$(XAPP_SETXKBMAP_VERSION).tar.xz
XAPP_SETXKBMAP_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_SETXKBMAP_LICENSE = MIT
XAPP_SETXKBMAP_LICENSE_FILES = COPYING
XAPP_SETXKBMAP_DEPENDENCIES = xlib_libX11 xlib_libxkbfile xlib_libXrandr

$(eval $(autotools-package))
