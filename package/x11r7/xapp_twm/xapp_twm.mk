################################################################################
#
# xapp_twm
#
################################################################################

XAPP_TWM_VERSION = 1.0.13.1
XAPP_TWM_SOURCE = twm-$(XAPP_TWM_VERSION).tar.xz
XAPP_TWM_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_TWM_LICENSE = MIT
XAPP_TWM_LICENSE_FILES = COPYING
XAPP_TWM_DEPENDENCIES = \
	host-bison xlib_libX11 xlib_libXext xlib_libXt xlib_libXmu

$(eval $(autotools-package))
