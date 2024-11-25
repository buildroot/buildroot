################################################################################
#
# libldns
#
################################################################################

LIBLDNS_VERSION = 1.8.4
LIBLDNS_SOURCE = ldns-$(LIBLDNS_VERSION).tar.gz
LIBLDNS_SITE = https://www.nlnetlabs.nl/downloads/ldns
LIBLDNS_LICENSE = BSD-3-Clause
LIBLDNS_LICENSE_FILES = LICENSE
LIBLDNS_CPE_ID_VENDOR = nlnetlabs
LIBLDNS_CPE_ID_PRODUCT = ldns
LIBLDNS_INSTALL_STAGING = YES
LIBLDNS_DEPENDENCIES = openssl
LIBLDNS_CONF_OPTS = \
	--with-ssl=$(STAGING_DIR)/usr \
	--enable-dane \
	--enable-ecdsa \
	--enable-sha2 \
	--without-examples \
	--without-p5-dns-ldns \
	--without-pyldns \
	--without-pyldnsx

ifeq ($(BR2_PACKAGE_LIBOPENSSL),y)
LIBLDNS_CONF_OPTS += --enable-dane-verify
else
LIBLDNS_CONF_OPTS += --disable-dane-verify
endif

ifeq ($(BR2_PACKAGE_LIBOPENSSL_ENGINES),y)
LIBLDNS_CONF_OPTS += --enable-gost
else
LIBLDNS_CONF_OPTS += --disable-gost
endif

ifeq ($(BR2_STATIC_LIBS),y)
LIBLDNS_DEPENDENCIES += host-pkgconf
# missing -lz breaks configure, add it using pkgconf
LIBLDNS_CONF_ENV += LIBS="`$(PKG_CONFIG_HOST_BINARY) --libs openssl`"
endif

# the linktest make target fails with static linking, and we are only
# interested in the lib target anyway
LIBLDNS_MAKE_OPTS = lib

$(eval $(autotools-package))
