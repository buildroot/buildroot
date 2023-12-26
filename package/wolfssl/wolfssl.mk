################################################################################
#
# wolfssl
#
################################################################################

WOLFSSL_VERSION = 5.6.6
WOLFSSL_SITE = https://github.com/wolfSSL/wolfssl/releases/download/v$(WOLFSSL_VERSION)-stable
WOLFSSL_INSTALL_STAGING = YES

WOLFSSL_LICENSE = GPL-2.0+
WOLFSSL_LICENSE_FILES = COPYING LICENSING
WOLFSSL_CPE_ID_VENDOR = wolfssl
WOLFSSL_CONFIG_SCRIPTS = wolfssl-config
WOLFSSL_DEPENDENCIES = host-pkgconf

WOLFSSL_CONF_OPTS = --disable-examples --disable-crypttests

ifeq ($(BR2_PACKAGE_WOLFSSL_ALL),y)
WOLFSSL_CONF_OPTS += --enable-all
else
WOLFSSL_CONF_OPTS += --disable-all
endif

ifeq ($(BR2_PACKAGE_WOLFSSL_SSLV3),y)
WOLFSSL_CONF_OPTS += --enable-sslv3
else
WOLFSSL_CONF_OPTS += --disable-sslv3
endif

ifeq ($(BR2_PACKAGE_WOLFSSL_ASM_SUPPORTS),y)
WOLFSSL_CONF_OPTS += --enable-asm
else
WOLFSSL_CONF_OPTS += --disable-asm
endif

# enable ARMv8 hardware acceleration
ifeq ($(BR2_aarch64),y)
WOLFSSL_CONF_OPTS += --enable-armasm
# the flag -mstrict-align is needed to prevent build errors caused by
# some inline assembly in parts of the AES structure using the "m"
# constraint
WOLFSSL_CONF_ENV += CPPFLAGS="$(TARGET_CPPFLAGS) -mstrict-align"
else
WOLFSSL_CONF_OPTS += --disable-armasm
endif

ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
WOLFSSL_CONF_OPTS += --with-arm-target=thumb
endif

$(eval $(autotools-package))
