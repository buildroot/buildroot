################################################################################
#
# libxcrypt
#
################################################################################

LIBXCRYPT_VERSION = 4.4.38
LIBXCRYPT_SITE = https://github.com/besser82/libxcrypt/releases/download/v$(LIBXCRYPT_VERSION)
LIBXCRYPT_SOURCE = libxcrypt-$(LIBXCRYPT_VERSION).tar.xz
LIBXCRYPT_LICENSE = LGPL-2.1+
LIBXCRYPT_LICENSE_FILES = LICENSING COPYING.LIB
LIBXCRYPT_INSTALL_STAGING = YES

# Some warnings turn into errors with some sensitive compilers
LIBXCRYPT_CONF_OPTS = --disable-werror
HOST_LIBXCRYPT_CONF_OPTS = --disable-werror

# Disable obsolete and insecure API
LIBXCRYPT_CONF_OPTS += --disable-obsolete_api
HOST_LIBXCRYPT_CONF_OPTS += --disable-obsolete_api

$(eval $(autotools-package))
$(eval $(host-autotools-package))
