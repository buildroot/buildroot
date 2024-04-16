################################################################################
#
# libjwt
#
################################################################################

LIBJWT_VERSION = 1.15.3
LIBJWT_SITE = $(call github,benmcollins,libjwt,v$(LIBJWT_VERSION))
LIBJWT_DEPENDENCIES = host-pkgconf jansson
LIBJWT_AUTORECONF = YES
LIBJWT_INSTALL_STAGING = YES
LIBJWT_LICENSE = MPL-2.0
LIBJWT_LICENSE_FILES = LICENSE
LIBJWT_CONF_OPTS = --without-examples

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBJWT_CONF_OPTS += --with-openssl
LIBJWT_DEPENDENCIES += openssl
else
LIBJWT_CONF_OPTS += --without-openssl
LIBJWT_DEPENDENCIES += gnutls
endif

$(eval $(autotools-package))
