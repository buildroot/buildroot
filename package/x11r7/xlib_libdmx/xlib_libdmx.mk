################################################################################
#
# xlib_libdmx
#
################################################################################

XLIB_LIBDMX_VERSION = 1.1.5
XLIB_LIBDMX_SOURCE = libdmx-$(XLIB_LIBDMX_VERSION).tar.xz
XLIB_LIBDMX_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBDMX_LICENSE = MIT
XLIB_LIBDMX_LICENSE_FILES = COPYING
XLIB_LIBDMX_CPE_ID_VENDOR = x
XLIB_LIBDMX_CPE_ID_PRODUCT = libdmx
XLIB_LIBDMX_INSTALL_STAGING = YES
XLIB_LIBDMX_DEPENDENCIES = xlib_libX11 xlib_libXext xorgproto
XLIB_LIBDMX_CONF_OPTS = --disable-malloc0returnsnull

$(eval $(autotools-package))
