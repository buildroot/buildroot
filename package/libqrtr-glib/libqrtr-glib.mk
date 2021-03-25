################################################################################
#
# libqrtr-glib
#
################################################################################

LIBQRTR_GLIB_VERSION = 1.0.0
LIBQRTR_GLIB_SITE = http://www.freedesktop.org/software/libqmi
LIBQRTR_GLIB_SOURCE = libqrtr-glib-$(LIBQRTR_GLIB_VERSION).tar.xz
LIBQRTR_GLIB_LICENSE = LGPL-2.1+
LIBQRTR_GLIB_LICENSE_FILES = COPYING.LIB
LIBQRTR_GLIB_INSTALL_STAGING = YES
LIBQRTR_GLIB_DEPENDENCIES = libglib2

$(eval $(autotools-package))
