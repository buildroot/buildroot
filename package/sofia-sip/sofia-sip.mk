################################################################################
#
# sofia-sip
#
################################################################################

SOFIA_SIP_VERSION = 1.13.15
SOFIA_SIP_SITE = $(call github,freeswitch,sofia-sip,v$(SOFIA_SIP_VERSION))
SOFIA_SIP_INSTALL_STAGING = YES
# Fetched from github, no pre-generated configure script provided
SOFIA_SIP_AUTORECONF = YES
SOFIA_SIP_DEPENDENCIES = host-pkgconf
SOFIA_SIP_LICENSE = LGPL-2.1+
SOFIA_SIP_LICENSE_FILES = COPYING COPYRIGHTS
SOFIA_SIP_CPE_ID_VENDOR = signalwire
SOFIA_SIP_CONF_OPTS = --with-doxygen=no

ifeq ($(BR2_PACKAGE_LIBGLIB2),y)
SOFIA_SIP_CONF_OPTS += --with-glib
SOFIA_SIP_DEPENDENCIES += libglib2
else
SOFIA_SIP_CONF_OPTS += --without-glib
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
SOFIA_SIP_CONF_OPTS += \
	--enable-nth \
	--with-openssl=pkg-config
SOFIA_SIP_DEPENDENCIES += openssl
else
SOFIA_SIP_CONF_OPTS += \
	--disable-nth \
	--without-openssl
endif

$(eval $(autotools-package))
