################################################################################
#
# libplist
#
################################################################################

LIBPLIST_VERSION = 2.4.0
LIBPLIST_SOURCE = libplist-$(LIBPLIST_VERSION).tar.bz2
LIBPLIST_SITE = https://github.com/libimobiledevice/libplist/releases/download/$(LIBPLIST_VERSION)
LIBPLIST_INSTALL_STAGING = YES
LIBPLIST_LICENSE = LGPL-2.1+
LIBPLIST_LICENSE_FILES = COPYING
LIBPLIST_CPE_ID_VENDOR = libimobiledevice

# Disable building Python bindings, because it requires host-cython, which
# is not packaged in Buildroot at all.
LIBPLIST_CONF_OPTS = --without-cython

$(eval $(autotools-package))
