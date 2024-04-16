################################################################################
#
# xlib_libXmu
#
################################################################################

XLIB_LIBXMU_VERSION = 1.1.4
XLIB_LIBXMU_SOURCE = libXmu-$(XLIB_LIBXMU_VERSION).tar.xz
XLIB_LIBXMU_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXMU_LICENSE = MIT
XLIB_LIBXMU_LICENSE_FILES = COPYING
XLIB_LIBXMU_INSTALL_STAGING = YES
XLIB_LIBXMU_DEPENDENCIES = xlib_libX11 xlib_libXext xlib_libXt xorgproto

$(eval $(autotools-package))
