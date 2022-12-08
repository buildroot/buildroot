################################################################################
#
# xapp_fslsfonts
#
################################################################################

XAPP_FSLSFONTS_VERSION = 1.0.6
XAPP_FSLSFONTS_SOURCE = fslsfonts-$(XAPP_FSLSFONTS_VERSION).tar.xz
XAPP_FSLSFONTS_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_FSLSFONTS_LICENSE = MIT
XAPP_FSLSFONTS_LICENSE_FILES = COPYING
XAPP_FSLSFONTS_DEPENDENCIES = xlib_libFS xlib_libX11

$(eval $(autotools-package))
