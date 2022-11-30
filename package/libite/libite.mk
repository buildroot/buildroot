################################################################################
#
# libite
#
################################################################################

LIBITE_VERSION = 2.5.2
LIBITE_SOURCE = libite-$(LIBITE_VERSION).tar.xz
LIBITE_SITE = https://github.com/troglobit/libite/releases/download/v$(LIBITE_VERSION)
LIBITE_LICENSE = MIT, X11, ISC, BSD-2-Clause
LIBITE_LICENSE_FILES = LICENSE src/chomp.c src/pidfile.c
LIBITE_INSTALL_STAGING = YES
LIBITE_CONF_OPTS = --without-symlink

$(eval $(autotools-package))
