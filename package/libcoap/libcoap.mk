################################################################################
#
# libcoap
#
################################################################################

LIBCOAP_VERSION = 4.3.1
LIBCOAP_SITE = $(call github,obgm,libcoap,v$(LIBCOAP_VERSION))
LIBCOAP_INSTALL_STAGING = YES
LIBCOAP_LICENSE = BSD-2-Clause
LIBCOAP_LICENSE_FILES = COPYING LICENSE
LIBCOAP_CPE_ID_VENDOR = libcoap
LIBCOAP_DEPENDENCIES = host-pkgconf
LIBCOAP_CONF_OPTS = \
	--disable-examples --disable-examples-source --without-tinydtls
LIBCOAP_AUTORECONF = YES
# 0001-Backport-fix-for-CVE-2023-30362.patch
LIBCOAP_IGNORE_CVES += CVE-2023-30362
# Doesn't affect 4.3.1, see https://github.com/obgm/libcoap/issues/1117
LIBCOAP_IGNORE_CVES += CVE-2023-35862

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

$(eval $(autotools-package))
