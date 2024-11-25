################################################################################
#
# openconnect
#
################################################################################

OPENCONNECT_VERSION = 9.12
OPENCONNECT_SITE = https://www.infradead.org/openconnect/download
OPENCONNECT_DEPENDENCIES = host-pkgconf libxml2 zlib
OPENCONNECT_LICENSE = LGPL-2.1
OPENCONNECT_LICENSE_FILES = COPYING.LGPL
OPENCONNECT_CONF_OPTS = \
	--disable-dsa-tests \
	--with-vpnc-script=/etc/vpnc/vpnc-script \
	--without-java

ifeq ($(BR2_PACKAGE_OPENSSL),y)
OPENCONNECT_DEPENDENCIES += openssl
OPENCONNECT_CONF_OPTS += --without-gnutls --with-openssl
else ifeq ($(BR2_PACKAGE_GNUTLS),y)
OPENCONNECT_DEPENDENCIES += gnutls
OPENCONNECT_CONF_OPTS += --with-gnutls --without-openssl
endif

ifeq ($(BR2_PACKAGE_LZ4),y)
OPENCONNECT_DEPENDENCIES += lz4
OPENCONNECT_CONF_OPTS += --with-lz4
else
OPENCONNECT_CONF_OPTS += --without-lz4
endif

$(eval $(autotools-package))
