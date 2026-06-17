################################################################################
#
# wget2
#
################################################################################

WGET2_VERSION = 2.2.1
WGET2_SITE = $(BR2_GNU_MIRROR)/wget
WGET2_DEPENDENCIES = host-pkgconf
WGET2_LICENSE = GPL-3.0+, LGPL-3.0+
WGET2_LICENSE_FILES = COPYING COPYING.LESSER
WGET2_CPE_ID_VENDOR = gnu

WGET2_CONF_OPTS = \
	--without-libhsts \
	--without-libmicrohttpd \
	--without-lzip

ifeq ($(BR2_PACKAGE_BROTLI),y)
WGET2_CONF_OPTS += --with-brotlidec
WGET2_DEPENDENCIES += brotli
else
WGET2_CONF_OPTS += --without-brotlidec
endif

ifeq ($(BR2_PACKAGE_BZIP2),y)
WGET2_CONF_OPTS += --with-bzip2
WGET2_DEPENDENCIES += bzip2
else
WGET2_CONF_OPTS += --without-bzip2
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
WGET2_CONF_OPTS += --with-ssl=gnutls
WGET2_DEPENDENCIES += gnutls
else ifeq ($(BR2_PACKAGE_OPENSSL),y)
WGET2_CONF_OPTS += --with-ssl=openssl
WGET2_DEPENDENCIES += openssl
else
WGET2_CONF_OPTS += --without-ssl
endif

ifeq ($(BR2_PACKAGE_LIBGPGME),y)
WGET2_CONF_OPTS += --with-gpgme
WGET2_DEPENDENCIES += libgpgme
else
WGET2_CONF_OPTS += --without-gpgme
endif

# BR2_ENABLE_LOCALE and BR2_PACKAGE_LIBICONV are mutually exclusive
ifeq ($(BR2_ENABLE_LOCALE)$(BR2_PACKAGE_LIBICONV)$(BR2_PACKAGE_LIBIDN2),yy)
WGET2_CONF_OPTS += --with-libidn2
WGET2_DEPENDENCIES += libidn2
else
WGET2_CONF_OPTS += --without-libidn2
endif

ifeq ($(BR2_PACKAGE_LIBPSL),y)
WGET2_CONF_OPTS += --with-libpsl
WGET2_DEPENDENCIES += libpsl
else
WGET2_CONF_OPTS += --without-libpsl
endif

ifeq ($(BR2_PACKAGE_NGHTTP2),y)
WGET2_CONF_OPTS += --with-libnghttp2
WGET2_DEPENDENCIES += nghttp2
else
WGET2_CONF_OPTS += --without-libnghttp2
endif

ifeq ($(BR2_PACKAGE_PCRE2),y)
WGET2_CONF_OPTS += --with-libpcre2
WGET2_DEPENDENCIES += pcre2
else
WGET2_CONF_OPTS += --without-libpcre2
endif

ifeq ($(BR2_PACKAGE_XZ),y)
WGET2_CONF_OPTS += --with-lzma
WGET2_DEPENDENCIES += xz
else
WGET2_CONF_OPTS += --without-lzma
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
WGET2_CONF_OPTS += --with-zlib
WGET2_DEPENDENCIES += zlib
else
WGET2_CONF_OPTS += --without-zlib
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
WGET2_CONF_OPTS += --with-zstd
WGET2_DEPENDENCIES += zstd
else
WGET2_CONF_OPTS += --without-zstd
endif

$(eval $(autotools-package))
