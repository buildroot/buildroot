################################################################################
#
# libjwt
#
################################################################################

LIBJWT_VERSION = 1.17.2
LIBJWT_SITE = https://github.com/benmcollins/libjwt/releases/download/v$(LIBJWT_VERSION)
LIBJWT_SOURCE = libjwt-$(LIBJWT_VERSION).tar.bz2
LIBJWT_DEPENDENCIES = host-pkgconf jansson
LIBJWT_INSTALL_STAGING = YES
LIBJWT_LICENSE = MPL-2.0
LIBJWT_LICENSE_FILES = LICENSE
LIBJWT_CPE_ID_VENDOR = bencollins
LIBJWT_CPE_ID_PRODUCT = jwt_c_library
LIBJWT_CONF_OPTS = --without-examples

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBJWT_CONF_OPTS += --with-openssl
LIBJWT_DEPENDENCIES += openssl
else
LIBJWT_CONF_OPTS += --without-openssl
LIBJWT_DEPENDENCIES += gnutls
endif

$(eval $(autotools-package))
