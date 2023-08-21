################################################################################
#
# libassuan
#
################################################################################

LIBASSUAN_VERSION = 2.5.6
LIBASSUAN_SITE = https://gnupg.org/ftp/gcrypt/libassuan
LIBASSUAN_SOURCE = libassuan-$(LIBASSUAN_VERSION).tar.bz2
LIBASSUAN_LICENSE = LGPL-2.1+ (library), GPL-3.0 (tests, doc)
LIBASSUAN_LICENSE_FILES = COPYING.LIB COPYING
LIBASSUAN_INSTALL_STAGING = YES
LIBASSUAN_DEPENDENCIES = libgpg-error
LIBASSUAN_CONF_OPTS = \
	--with-gpg-error-prefix=$(STAGING_DIR)/usr
LIBASSUAN_CONFIG_SCRIPTS = libassuan-config

# Force the path to "gpgrt-config" (from the libgpg-error package) to
# avoid using the one on host, if present.
LIBASSUAN_CONF_ENV += GPGRT_CONFIG=$(STAGING_DIR)/usr/bin/gpgrt-config

$(eval $(autotools-package))
