################################################################################
#
# xlib_libXaw
#
################################################################################

XLIB_LIBXAW_VERSION = 1.0.15
XLIB_LIBXAW_SOURCE = libXaw-$(XLIB_LIBXAW_VERSION).tar.xz
XLIB_LIBXAW_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXAW_LICENSE = MIT
XLIB_LIBXAW_LICENSE_FILES = COPYING
XLIB_LIBXAW_INSTALL_STAGING = YES
XLIB_LIBXAW_DEPENDENCIES = xlib_libX11 xlib_libXt xlib_libXmu xlib_libXpm xorgproto

$(eval $(autotools-package))
