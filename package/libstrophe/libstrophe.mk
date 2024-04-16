################################################################################
#
# libstrophe
#
################################################################################

LIBSTROPHE_VERSION = 0.13.1
LIBSTROPHE_SOURCE = libstrophe-$(LIBSTROPHE_VERSION).tar.xz
LIBSTROPHE_SITE = https://github.com/strophe/libstrophe/releases/download/$(LIBSTROPHE_VERSION)
LIBSTROPHE_DEPENDENCIES = host-pkgconf
LIBSTROPHE_LICENSE = MIT or GPL-3.0
LIBSTROPHE_LICENSE_FILES = MIT-LICENSE.txt GPL-LICENSE.txt
LIBSTROPHE_INSTALL_STAGING = YES
LIBSTROPHE_CONF_OPTS = --disable-examples

ifeq ($(BR2_PACKAGE_C_ARES),y)
LIBSTROPHE_CONF_OPTS += --enable-cares
LIBSTROPHE_DEPENDENCIES += c-ares
else
LIBSTROPHE_CONF_OPTS += --disable-cares
endif

ifeq ($(BR2_PACKAGE_EXPAT),y)
LIBSTROPHE_CONF_OPTS += --without-libxml2
LIBSTROPHE_DEPENDENCIES += expat
else
LIBSTROPHE_CONF_OPTS += --with-libxml2
LIBSTROPHE_DEPENDENCIES += libxml2
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBSTROPHE_CONF_OPTS += --with-tls --without-gnutls
LIBSTROPHE_DEPENDENCIES += openssl
else
LIBSTROPHE_CONF_OPTS += --with-gnutls --without-tls
LIBSTROPHE_DEPENDENCIES += gnutls
endif

$(eval $(autotools-package))
