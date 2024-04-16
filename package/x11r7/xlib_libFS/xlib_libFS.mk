################################################################################
#
# xlib_libFS
#
################################################################################

XLIB_LIBFS_VERSION = 1.0.9
XLIB_LIBFS_SOURCE = libFS-$(XLIB_LIBFS_VERSION).tar.xz
XLIB_LIBFS_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBFS_LICENSE = MIT
XLIB_LIBFS_LICENSE_FILES = COPYING
XLIB_LIBFS_CPE_ID_VENDOR = x
XLIB_LIBFS_CPE_ID_PRODUCT = libfs
XLIB_LIBFS_INSTALL_STAGING = YES
XLIB_LIBFS_DEPENDENCIES = xlib_xtrans xorgproto host-pkgconf
XLIB_LIBFS_CONF_OPTS = --disable-malloc0returnsnull

$(eval $(autotools-package))
