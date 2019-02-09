LIBXMLSEC1_VERSION = 1.2.27
LIBXMLSEC1_SOURCE = xmlsec1-${LIBXMLSEC1_VERSION}.tar.gz
LIBXMLSEC1_SITE = http://www.aleksey.com/xmlsec/download
LIBXMLSEC1_INSTALL_STAGING = YES
LIBXMLSEC1_INSTALL_TARGET = YES
LIBXMLSEC1_LICENSE = MIT
LIBXMLSEC1_LICENSE_FILES = Copyright

LIBXMLSEC1_CONF_OPTS += --disable-static
LIBXMLSEC1_CONF_OPTS += --enable-crypto-dl=no
LIBXMLSEC1_CONF_OPTS += --with-openssl=${STAGING_DIR}/usr
LIBXMLSEC1_CONF_OPTS += --with-libxslt=no
LIBXMLSEC1_CONF_OPTS += --with-gnutls=no
LIBXMLSEC1_CONF_OPTS += --with-gcrypt=no
LIBXMLSEC1_DEPENDENCIES = libxml2 libxslt openssl

$(eval $(autotools-package))
