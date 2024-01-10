################################################################################
#
# kvazaar
#
################################################################################

KVAZAAR_VERSION = 2.2.0
KVAZAAR_SOURCE = kvazaar-$(KVAZAAR_VERSION).tar.xz
KVAZAAR_SITE = https://github.com/ultravideo/kvazaar/releases/download/v$(KVAZAAR_VERSION)
KVAZAAR_LICENSE = BSD-3-Clause, ISC (greatest, x264asm)
KVAZAAR_LICENSE_FILES = LICENSE LICENSE.EXT.greatest LICENSE.EXT.x264asm
KVAZAAR_INSTALL_STAGING = YES
KVAZAAR_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_PACKAGE_CRYPTOPP),y)
KVAZAAR_DEPENDENCIES += cryptopp
KVAZAAR_CONF_OPTS += --with-cryptopp
else
KVAZAAR_CONF_OPTS += --without-cryptopp
endif

$(eval $(autotools-package))
