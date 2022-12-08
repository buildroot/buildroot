################################################################################
#
# xapp_showfont
#
################################################################################

XAPP_SHOWFONT_VERSION = 1.0.6
XAPP_SHOWFONT_SOURCE = showfont-$(XAPP_SHOWFONT_VERSION).tar.xz
XAPP_SHOWFONT_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_SHOWFONT_LICENSE = MIT
XAPP_SHOWFONT_LICENSE_FILES = COPYING
XAPP_SHOWFONT_DEPENDENCIES = xlib_libFS

$(eval $(autotools-package))
