################################################################################
#
# xapp_xlogo
#
################################################################################

XAPP_XLOGO_VERSION = 1.0.6
XAPP_XLOGO_SOURCE = xlogo-$(XAPP_XLOGO_VERSION).tar.xz
XAPP_XLOGO_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XLOGO_LICENSE = MIT
XAPP_XLOGO_LICENSE_FILES = COPYING
XAPP_XLOGO_DEPENDENCIES = \
	xlib_libXaw xlib_libXrender \
	xlib_libXft host-pkgconf

$(eval $(autotools-package))
