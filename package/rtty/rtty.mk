################################################################################
#
# rtty
#
################################################################################

RTTY_VERSION = 8.1.2
RTTY_SITE = https://github.com/zhaojh329/rtty/releases/download/v$(RTTY_VERSION)
RTTY_LICENSE = MIT
RTTY_LICENSE_FILES = LICENSE
RTTY_DEPENDENCIES = libev

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
RTTY_DEPENDENCIES += libxcrypt
endif

ifeq ($(BR2_PACKAGE_MBEDTLS),y)
RTTY_DEPENDENCIES += mbedtls
RTTY_CONF_OPTS += \
	-DSSL_SUPPORT=ON \
	-DUSE_MBEDTLS=ON \
	-DUSE_OPENSSL=OFF \
	-DUSE_WOLFSSL=OFF
else ifeq ($(BR2_PACKAGE_OPENSSL),y)
RTTY_DEPENDENCIES += host-pkgconf openssl
RTTY_CONF_OPTS += \
	-DSSL_SUPPORT=ON \
	-DUSE_MBEDTLS=OFF \
	-DUSE_OPENSSL=ON \
	-DUSE_WOLFSSL=OFF
else ifeq ($(BR2_PACKAGE_WOLFSSL_ALL),y)
RTTY_DEPENDENCIES += wolfssl
RTTY_CONF_OPTS += \
	-DSSL_SUPPORT=ON \
	-DUSE_MBEDTLS=OFF \
	-DUSE_OPENSSL=OFF \
	-DUSE_WOLFSSL=ON
else
RTTY_CONF_OPTS += -DSSL_SUPPORT=OFF
endif

$(eval $(cmake-package))
