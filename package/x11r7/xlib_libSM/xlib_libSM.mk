################################################################################
#
# xlib_libSM
#
################################################################################

XLIB_LIBSM_VERSION = 1.2.4
XLIB_LIBSM_SOURCE = libSM-$(XLIB_LIBSM_VERSION).tar.xz
XLIB_LIBSM_SITE = https://xorg.freedesktop.org/archive/individual/lib
XLIB_LIBSM_LICENSE = MIT
XLIB_LIBSM_LICENSE_FILES = COPYING
XLIB_LIBSM_INSTALL_STAGING = YES
XLIB_LIBSM_DEPENDENCIES = xlib_libICE xlib_xtrans xorgproto
XLIB_LIBSM_CONF_OPTS = --without-libuuid

$(eval $(autotools-package))
