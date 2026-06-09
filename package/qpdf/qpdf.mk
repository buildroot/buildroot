################################################################################
#
# qpdf
#
################################################################################

QPDF_VERSION = 12.3.2
QPDF_SITE = https://github.com/qpdf/qpdf/releases/download/v$(QPDF_VERSION)
QPDF_INSTALL_STAGING = YES
QPDF_LICENSE = Apache-2.0 or Artistic-2.0
QPDF_LICENSE_FILES = LICENSE.txt Artistic-2.0
QPDF_CPE_ID_VALID = YES
QPDF_DEPENDENCIES = host-pkgconf zlib jpeg
QPDF_SUPPORTS_IN_SOURCE_BUILD = NO

QPDF_CONF_OPTS = \
	-DUSE_IMPLICIT_CRYPTO=OFF \
	-DREQUIRE_CRYPTO_NATIVE=ON

ifeq ($(BR2_PACKAGE_GNUTLS),y)
QPDF_CONF_OPTS += -DREQUIRE_CRYPTO_GNUTLS=ON
QPDF_DEPENDENCIES += gnutls
else
QPDF_CONF_OPTS += -DREQUIRE_CRYPTO_GNUTLS=OFF
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
QPDF_CONF_OPTS += -DREQUIRE_CRYPTO_OPENSSL=ON
QPDF_DEPENDENCIES += openssl
else
QPDF_CONF_OPTS += -DREQUIRE_CRYPTO_OPENSSL=OFF
endif

$(eval $(cmake-package))
