################################################################################
#
# xlib_libfontenc
#
################################################################################

XLIB_LIBFONTENC_VERSION = 1.1.8
XLIB_LIBFONTENC_SOURCE = libfontenc-$(XLIB_LIBFONTENC_VERSION).tar.xz
XLIB_LIBFONTENC_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBFONTENC_LICENSE = MIT
XLIB_LIBFONTENC_LICENSE_FILES = COPYING
XLIB_LIBFONTENC_INSTALL_STAGING = YES
XLIB_LIBFONTENC_DEPENDENCIES = zlib xorgproto host-pkgconf
HOST_XLIB_LIBFONTENC_DEPENDENCIES = host-zlib host-xorgproto host-pkgconf

$(eval $(autotools-package))
$(eval $(host-autotools-package))
