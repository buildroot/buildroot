################################################################################
#
# sngrep
#
################################################################################

SNGREP_VERSION = 1.7.0
SNGREP_SITE = \
	https://github.com/irontec/sngrep/releases/download/v$(SNGREP_VERSION)
SNGREP_LICENSE = GPL-3.0+
SNGREP_LICENSE_FILES = LICENSE
SNGREP_CPE_ID_VENDOR = irontec
SNGREP_AUTORECONF = YES
SNGREP_DEPENDENCIES = libpcap ncurses host-pkgconf

SNGREP_CONF_ENV += \
	$(if $(BR2_STATIC_LIBS),LIBS="`$(STAGING_DIR)/usr/bin/pcap-config --static --libs`")

SNGREP_CONF_OPTS += --disable-unicode

# openssl and gnutls can't be enabled at the same time.
ifeq ($(BR2_PACKAGE_OPENSSL),y)
SNGREP_DEPENDENCIES += openssl
SNGREP_CONF_OPTS += --with-openssl --without-gnutls
# gnutls support also requires libgcrypt
else ifeq ($(BR2_PACKAGE_GNUTLS)$(BR2_PACKAGE_LIBGCRYPT),yy)
SNGREP_CONF_ENV += LIBGCRYPT_CONFIG=$(STAGING_DIR)/usr/bin/libgcrypt-config
SNGREP_DEPENDENCIES += gnutls libgcrypt
SNGREP_CONF_OPTS += --with-gnutls --without-openssl
else
SNGREP_CONF_OPTS += --without-gnutls --without-openssl
endif

ifeq ($(BR2_PACKAGE_PCRE2),y)
SNGREP_DEPENDENCIES += pcre2
SNGREP_CONF_OPTS += --without-pcre --with-pcre2
else ifeq ($(BR2_PACKAGE_PCRE),y)
SNGREP_DEPENDENCIES += pcre
SNGREP_CONF_OPTS += --with-pcre --without-pcre2
else
SNGREP_CONF_OPTS += --without-pcre --without-pcre2
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
SNGREP_DEPENDENCIES += zlib
SNGREP_CONF_OPTS += --with-zlib
else
SNGREP_CONF_OPTS += --without-zlib
endif

$(eval $(autotools-package))
