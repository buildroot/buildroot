################################################################################
#
# libxcrypt
#
################################################################################

LIBXCRYPT_VERSION = 4.4.17
LIBXCRYPT_SITE = $(call github,besser82,libxcrypt,v$(LIBXCRYPT_VERSION))
LIBXCRYPT_LICENSE = LGPL-2.1+
LIBXCRYPT_LICENSE_FILES = LICENSING COPYING.LIB
LIBXCRYPT_INSTALL_STAGING = YES
LIBXCRYPT_AUTORECONF = YES

$(eval $(autotools-package))
