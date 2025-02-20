################################################################################
#
# libjwt
#
################################################################################

LIBJWT_VERSION = 3.2.0
LIBJWT_SITE = https://github.com/benmcollins/libjwt/releases/download/v$(LIBJWT_VERSION)
LIBJWT_SOURCE = libjwt-$(LIBJWT_VERSION).tar.xz
LIBJWT_DEPENDENCIES = host-pkgconf jansson
LIBJWT_INSTALL_STAGING = YES
LIBJWT_LICENSE = MPL-2.0
LIBJWT_LICENSE_FILES = LICENSE
LIBJWT_CPE_ID_VENDOR = bencollins
LIBJWT_CPE_ID_PRODUCT = jwt_c_library

LIBJWT_CONF_OPTS += -DWITH_TESTS=OFF

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBJWT_CONF_OPTS += -DWITH_OPENSSL=ON
LIBJWT_DEPENDENCIES += openssl
else
LIBJWT_CONF_OPTS += -DWITH_GNUTLS=ON
LIBJWT_DEPENDENCIES += gnutls
endif

$(eval $(cmake-package))
