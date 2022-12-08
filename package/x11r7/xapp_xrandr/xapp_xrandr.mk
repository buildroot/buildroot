################################################################################
#
# xapp_xrandr
#
################################################################################

XAPP_XRANDR_VERSION = 1.5.2
XAPP_XRANDR_SOURCE = xrandr-$(XAPP_XRANDR_VERSION).tar.xz
XAPP_XRANDR_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XRANDR_LICENSE = MIT
XAPP_XRANDR_LICENSE_FILES = COPYING
XAPP_XRANDR_DEPENDENCIES = xlib_libXrandr xlib_libX11
XAPP_XRANDR_CONF_OPTS = --disable-malloc0returnsnull

$(eval $(autotools-package))
