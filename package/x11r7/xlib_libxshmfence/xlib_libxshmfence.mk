################################################################################
#
# xlib_libxshmfence
#
################################################################################

XLIB_LIBXSHMFENCE_VERSION = 1.3.3
XLIB_LIBXSHMFENCE_SOURCE = libxshmfence-$(XLIB_LIBXSHMFENCE_VERSION).tar.xz
XLIB_LIBXSHMFENCE_SITE = http://xorg.freedesktop.org/releases/individual/lib
XLIB_LIBXSHMFENCE_LICENSE = MIT
XLIB_LIBXSHMFENCE_LICENSE_FILES = COPYING
XLIB_LIBXSHMFENCE_INSTALL_STAGING = YES
XLIB_LIBXSHMFENCE_DEPENDENCIES = host-pkgconf xorgproto

# default 'auto' leaks context from host
XLIB_LIBXSHMFENCE_CONF_OPTS = --with-shared-memory-dir=/dev/shm

$(eval $(autotools-package))
