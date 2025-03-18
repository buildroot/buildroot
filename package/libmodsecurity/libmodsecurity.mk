################################################################################
#
# libmodsecurity
#
################################################################################

LIBMODSECURITY_VERSION = 3.0.14
LIBMODSECURITY_SOURCE = modsecurity-v$(LIBMODSECURITY_VERSION).tar.gz
LIBMODSECURITY_SITE = https://github.com/owasp-modsecurity/ModSecurity/releases/download/v$(LIBMODSECURITY_VERSION)
LIBMODSECURITY_INSTALL_STAGING = YES
LIBMODSECURITY_LICENSE = Apache-2.0
LIBMODSECURITY_LICENSE_FILES = LICENSE
LIBMODSECURITY_CPE_ID_VENDOR = trustwave
LIBMODSECURITY_CPE_ID_PRODUCT = modsecurity

LIBMODSECURITY_DEPENDENCIES = pcre2
LIBMODSECURITY_CONF_OPTS = \
	--without-pcre \
	--with-pcre2="$(STAGING_DIR)/usr" \
	--disable-examples \
	--without-lmdb \
	--without-ssdeep \
	--without-lua \
	--without-yajl

ifeq ($(BR2_PACKAGE_LIBXML2),y)
LIBMODSECURITY_DEPENDENCIES += libxml2
LIBMODSECURITY_CONF_OPTS += --with-libxml="$(STAGING_DIR)/usr/bin/xml2-config"
else
LIBMODSECURITY_CONF_OPTS += --without-libxml
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
LIBMODSECURITY_DEPENDENCIES += libcurl
LIBMODSECURITY_CONF_OPTS += --with-curl="$(STAGING_DIR)/usr/bin/curl-config"
else
LIBMODSECURITY_CONF_OPTS += --without-curl
endif

ifeq ($(BR2_PACKAGE_GEOIP),y)
LIBMODSECURITY_DEPENDENCIES += geoip
LIBMODSECURITY_CONF_OPTS += --with-geoip
else
LIBMODSECURITY_CONF_OPTS += --without-geoip
endif

ifeq ($(BR2_PACKAGE_LIBMAXMINDDB),y)
LIBMODSECURITY_DEPENDENCIES += libmaxminddb
LIBMODSECURITY_CONF_OPTS += --with-maxmind
else
LIBMODSECURITY_CONF_OPTS += --without-maxmind
endif

LIBMODSECURITY_CXXFLAGS = $(TARGET_CXXFLAGS)

# m68k_cf can't use -fPIC that libmodsecurity forces to use, so we need
# to disable it to avoid a build failure.
ifeq ($(BR2_m68k_cf),y)
LIBMODSECURITY_CXXFLAGS += -fno-PIC
endif

LIBMODSECURITY_CONF_OPTS += CXXFLAGS="$(LIBMODSECURITY_CXXFLAGS)"

$(eval $(autotools-package))
