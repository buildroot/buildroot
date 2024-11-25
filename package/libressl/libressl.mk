################################################################################
#
# libressl
#
################################################################################

LIBRESSL_VERSION = 3.9.2
LIBRESSL_SITE = https://ftp.openbsd.org/pub/OpenBSD/LibreSSL
LIBRESSL_LICENSE = ISC (new additions), OpenSSL or SSLeay (original OpenSSL code)
LIBRESSL_LICENSE_FILES = COPYING
LIBRESSL_CPE_ID_VENDOR = openbsd
LIBRESSL_INSTALL_STAGING = YES
LIBRESSL_CONF_OPTS = -DLIBRESSL_TESTS=OFF -DOPENSSLDIR="/etc/ssl"

# Otherwise fails to build with undefined reference to
# `bn_mul_add_words'
ifeq ($(BR2_powerpc)$(BR2_mips64)$(BR2_mips64el),y)
LIBRESSL_CONF_OPTS += -DENABLE_ASM=OFF
endif

ifeq ($(BR2_PACKAGE_LIBRESSL_BIN),)
define LIBRESSL_REMOVE_BIN
	$(RM) -f $(TARGET_DIR)/usr/bin/openssl
endef
LIBRESSL_POST_INSTALL_TARGET_HOOKS += LIBRESSL_REMOVE_BIN
endif

$(eval $(cmake-package))
