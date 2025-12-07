################################################################################
#
# ustream-ssl
#
################################################################################

USTREAM_SSL_VERSION = 5a81c108d20e24724ed847cc4be033f2a74e6635
USTREAM_SSL_SITE = https://git.openwrt.org/project/ustream-ssl.git
USTREAM_SSL_SITE_METHOD = git
USTREAM_SSL_LICENSE = ISC
USTREAM_SSL_LICENSE_FILES = ustream-ssl.h
USTREAM_SSL_INSTALL_STAGING = YES
USTREAM_SSL_DEPENDENCIES = libubox

ifeq ($(BR2_PACKAGE_MBEDTLS),y)
USTREAM_SSL_DEPENDENCIES += mbedtls
USTREAM_SSL_CONF_OPTS += -DMBEDTLS=ON
else
USTREAM_SSL_DEPENDENCIES += openssl
endif

$(eval $(cmake-package))
