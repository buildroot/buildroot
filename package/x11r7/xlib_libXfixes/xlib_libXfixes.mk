################################################################################
#
# xlib_libXfixes
#
################################################################################

XLIB_LIBXFIXES_VERSION = 6.0.1
XLIB_LIBXFIXES_SOURCE = libXfixes-$(XLIB_LIBXFIXES_VERSION).tar.xz
XLIB_LIBXFIXES_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXFIXES_LICENSE = MIT
XLIB_LIBXFIXES_LICENSE_FILES = COPYING
XLIB_LIBXFIXES_CPE_ID_VENDOR = x
XLIB_LIBXFIXES_CPE_ID_PRODUCT = libxfixes
XLIB_LIBXFIXES_INSTALL_STAGING = YES
XLIB_LIBXFIXES_DEPENDENCIES =  xlib_libX11 xorgproto
HOST_XLIB_LIBXFIXES_DEPENDENCIES = \
	host-xlib_libX11 host-xorgproto

$(eval $(autotools-package))
$(eval $(host-autotools-package))
