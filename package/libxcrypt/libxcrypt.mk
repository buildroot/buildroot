################################################################################
#
# libxcrypt
#
################################################################################

LIBXCRYPT_VERSION = 4.4.26
LIBXCRYPT_SITE = $(call github,besser82,libxcrypt,v$(LIBXCRYPT_VERSION))
LIBXCRYPT_LICENSE = LGPL-2.1+
LIBXCRYPT_LICENSE_FILES = LICENSING COPYING.LIB
LIBXCRYPT_INSTALL_STAGING = YES
LIBXCRYPT_AUTORECONF = YES

# Some warnings turn into errors with some sensitive compilers
LIBXCRYPT_CONF_OPTS = --disable-werror

# Disable obsolete and unsecure API
LIBXCRYPT_CONF_OPTS += --disable-obsolete_api

$(eval $(autotools-package))
