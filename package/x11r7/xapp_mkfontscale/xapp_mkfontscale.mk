################################################################################
#
# xapp_mkfontscale
#
################################################################################

XAPP_MKFONTSCALE_VERSION = 1.2.3
XAPP_MKFONTSCALE_SOURCE = mkfontscale-$(XAPP_MKFONTSCALE_VERSION).tar.xz
XAPP_MKFONTSCALE_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_MKFONTSCALE_LICENSE = MIT
XAPP_MKFONTSCALE_LICENSE_FILES = COPYING
XAPP_MKFONTSCALE_DEPENDENCIES = zlib freetype xlib_libfontenc xorgproto
HOST_XAPP_MKFONTSCALE_DEPENDENCIES = \
	host-zlib host-freetype host-xlib_libfontenc host-xorgproto

$(eval $(autotools-package))
$(eval $(host-autotools-package))
