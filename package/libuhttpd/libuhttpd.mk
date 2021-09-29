################################################################################
#
# libuhttpd
#
################################################################################

LIBUHTTPD_VERSION = 3.12.1
LIBUHTTPD_SITE = https://github.com/zhaojh329/libuhttpd/releases/download/v$(LIBUHTTPD_VERSION)
LIBUHTTPD_LICENSE = MIT
LIBUHTTPD_LICENSE_FILES = LICENSE
LIBUHTTPD_INSTALL_STAGING = YES
LIBUHTTPD_DEPENDENCIES = libev

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBUHTTPD_DEPENDENCIES += openssl
LIBUHTTPD_CONF_OPTS += \
	-DSSL_SUPPORT=ON \
	-DUSE_MBEDTLS=OFF \
	-DUSE_OPENSSL=ON \
	-DUSE_WOLFSSL=OFF
else ifeq ($(BR2_PACKAGE_WOLFSSL),y)
LIBUHTTPD_DEPENDENCIES += wolfssl
LIBUHTTPD_CONF_OPTS += \
	-DSSL_SUPPORT=ON \
	-DUSE_MBEDTLS=OFF \
	-DUSE_OPENSSL=OFF \
	-DUSE_WOLFSSL=ON
else ifeq ($(BR2_PACKAGE_MBEDTLS),y)
LIBUHTTPD_DEPENDENCIES += mbedtls
LIBUHTTPD_CONF_OPTS += \
	-DSSL_SUPPORT=ON \
	-DUSE_MBEDTLS=ON \
	-DUSE_OPENSSL=OFF \
	-DUSE_WOLFSSL=OFF
else
LIBUHTTPD_CONF_OPTS += \
	-DSSL_SUPPORT=OFF
endif

# BUILD_STATIC builds *only* the static lib, which is not what we want for
# BR2_SHARED_STATIC.
ifeq ($(BR2_STATIC_LIBS),y)
LIBUHTTPD_CONF_OPTS += -DBUILD_STATIC=ON
else
LIBUHTTPD_CONF_OPTS += -DBUILD_STATIC=OFF
endif

$(eval $(cmake-package))
