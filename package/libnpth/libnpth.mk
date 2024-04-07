################################################################################
#
# libnpth
#
################################################################################

LIBNPTH_VERSION = 1.7
LIBNPTH_SOURCE = npth-$(LIBNPTH_VERSION).tar.bz2
LIBNPTH_SITE = https://www.gnupg.org/ftp/gcrypt/npth
LIBNPTH_LICENSE = LGPL-2.0+
LIBNPTH_LICENSE_FILES = COPYING.LIB
LIBNPTH_INSTALL_STAGING = YES
# 0001-Fix-INSERT_EXPOSE_RWLOCK_API-for-musl-C-library.patch
LIBNPTH_AUTORECONF = YES
LIBNPTH_CONF_OPTS = --disable-tests

$(eval $(autotools-package))
