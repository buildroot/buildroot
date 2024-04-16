################################################################################
#
# xlib_libXxf86vm
#
################################################################################

XLIB_LIBXXF86VM_VERSION = 1.1.5
XLIB_LIBXXF86VM_SOURCE = libXxf86vm-$(XLIB_LIBXXF86VM_VERSION).tar.xz
XLIB_LIBXXF86VM_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBXXF86VM_LICENSE = MIT
XLIB_LIBXXF86VM_LICENSE_FILES = COPYING
XLIB_LIBXXF86VM_CPE_ID_VENDOR = x
XLIB_LIBXXF86VM_CPE_ID_PRODUCT = libxxf86vm
XLIB_LIBXXF86VM_INSTALL_STAGING = YES
XLIB_LIBXXF86VM_DEPENDENCIES = xlib_libX11 xlib_libXext xorgproto
XLIB_LIBXXF86VM_CONF_OPTS = --disable-malloc0returnsnull

$(eval $(autotools-package))
