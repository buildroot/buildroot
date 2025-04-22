################################################################################
#
# libcoap
#
################################################################################

LIBCOAP_VERSION = 4.3.5
LIBCOAP_SITE = $(call github,obgm,libcoap,v$(LIBCOAP_VERSION))
LIBCOAP_INSTALL_STAGING = YES
LIBCOAP_LICENSE = BSD-2-Clause
LIBCOAP_LICENSE_FILES = COPYING LICENSE
LIBCOAP_CPE_ID_VENDOR = libcoap
LIBCOAP_DEPENDENCIES = host-pkgconf
LIBCOAP_CONF_OPTS = \
	--disable-examples --disable-examples-source --without-tinydtls
LIBCOAP_AUTORECONF = YES

ifeq ($(BR2_PACKAGE_GNUTLS),y)
LIBCOAP_DEPENDENCIES += gnutls
LIBCOAP_CONF_OPTS += \
	--enable-dtls --with-gnutls --without-mbedtls --without-openssl
else ifeq ($(BR2_PACKAGE_LIBOPENSSL),y)
LIBCOAP_DEPENDENCIES += openssl
LIBCOAP_CONF_OPTS += \
	--enable-dtls --without-gnutls --without-mbedtls --with-openssl
else ifeq ($(BR2_PACKAGE_MBEDTLS),y)
LIBCOAP_DEPENDENCIES += mbedtls
LIBCOAP_CONF_OPTS += \
	--enable-dtls --without-gnutls --with-mbedtls --without-openssl
else
LIBCOAP_CONF_OPTS += --disable-dtls
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
LIBCOAP_CONF_OPTS += --enable-thread-safe
else
LIBCOAP_CONF_OPTS += --disable-thread-safe
endif

$(eval $(autotools-package))
