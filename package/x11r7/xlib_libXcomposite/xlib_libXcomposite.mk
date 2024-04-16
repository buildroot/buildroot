################################################################################
#
# xlib_libXcomposite
#
################################################################################

XLIB_LIBXCOMPOSITE_VERSION = 0.4.6
XLIB_LIBXCOMPOSITE_SOURCE = libXcomposite-$(XLIB_LIBXCOMPOSITE_VERSION).tar.xz
XLIB_LIBXCOMPOSITE_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXCOMPOSITE_LICENSE = MIT
XLIB_LIBXCOMPOSITE_LICENSE_FILES = COPYING
XLIB_LIBXCOMPOSITE_INSTALL_STAGING = YES
XLIB_LIBXCOMPOSITE_DEPENDENCIES = xlib_libX11 xlib_libXext xlib_libXfixes xorgproto

$(eval $(autotools-package))
