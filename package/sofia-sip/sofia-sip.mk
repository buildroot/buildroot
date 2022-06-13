################################################################################
#
# sofia-sip
#
################################################################################

SOFIA_SIP_VERSION = 1.13.8
SOFIA_SIP_SOURCE = sofia-sip-$(SOFIA_SIP_VERSION)-756ab9b5c9.tar.gz
SOFIA_SIP_SITE = https://files.freeswitch.org/downloads/libs/sofia-sip
SOFIA_SIP_INSTALL_STAGING = YES
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
