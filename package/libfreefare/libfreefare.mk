################################################################################
#
# libfreefare
#
################################################################################

LIBFREEFARE_VERSION = c2b0cfa4b9fb0e4be88604f00b7a2405618d5abc
LIBFREEFARE_SITE = $(call github,nfc-tools,libfreefare,$(LIBFREEFARE_VERSION))
LIBFREEFARE_DEPENDENCIES = host-pkgconf libnfc openssl
LIBFREEFARE_LICENSE = LGPL-3.0+ with exception
LIBFREEFARE_LICENSE_FILES = COPYING
# From git
LIBFREEFARE_AUTORECONF = YES
LIBFREEFARE_CONF_ENV += LIBS=`$(PKG_CONFIG_HOST_BINARY) --libs openssl`

$(eval $(autotools-package))
