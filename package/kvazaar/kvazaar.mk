################################################################################
#
# kvazaar
#
################################################################################

KVAZAAR_VERSION = 2.1.0
KVAZAAR_SOURCE = kvazaar-$(KVAZAAR_VERSION).tar.xz
KVAZAAR_SITE = https://github.com/ultravideo/kvazaar/releases/download/v$(KVAZAAR_VERSION)
KVAZAAR_LICENSE = BSD-3-Clause, ISC (greatest, x264asm)
KVAZAAR_LICENSE_FILES = LICENSE LICENSE.greatest LICENSE.x264asm
KVAZAAR_INSTALL_STAGING = YES
KVAZAAR_DEPENDENCIES = host-pkgconf
KVAZAAR_CONF_OPTS = --without-cryptopp

$(eval $(autotools-package))
