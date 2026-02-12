################################################################################
#
# libxmlsec1
#
################################################################################

LIBXMLSEC1_VERSION = 1.3.9
LIBXMLSEC1_SOURCE = xmlsec1-$(LIBXMLSEC1_VERSION).tar.gz
LIBXMLSEC1_SITE = https://github.com/lsh123/xmlsec/releases/download/$(LIBXMLSEC1_VERSION)
LIBXMLSEC1_LICENSE = MIT
LIBXMLSEC1_LICENSE_FILES = Copyright
LIBXMLSEC1_INSTALL_STAGING = YES
LIBXMLSEC1_DEPENDENCIES = libxml2 openssl
HOST_LIBXMLSEC1_DEPENDENCIES = host-libxml2 host-openssl
LIBXMLSEC1_AUTORECONF = YES

LIBXMLSEC1_CONF_OPTS = \
	--enable-crypto-dl=no \
	--with-openssl \
	--without-gnutls \
	--without-gcrypt \
	--without-nss

HOST_LIBXMLSEC1_CONF_OPTS = \
	--enable-crypto-dl=no \
	--with-openssl \
	--without-gnutls \
	--without-gcrypt \
	--without-nss \
	--without-libxslt

ifeq ($(BR2_PACKAGE_LIBXSLT),y)
LIBXMLSEC1_DEPENDENCIES += libxslt
LIBXMLSEC1_CONF_OPTS += --with-libxslt
else
LIBXMLSEC1_CONF_OPTS += --without-libxslt
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
