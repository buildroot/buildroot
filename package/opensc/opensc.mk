################################################################################
#
# opensc
#
################################################################################

OPENSC_VERSION = 0.26.0
OPENSC_SITE = https://github.com/OpenSC/OpenSC/releases/download/$(OPENSC_VERSION)
OPENSC_LICENSE = LGPL-2.1+
OPENSC_LICENSE_FILES = COPYING
OPENSC_CPE_ID_VALID = YES
OPENSC_DEPENDENCIES = pcsc-lite
OPENSC_INSTALL_STAGING = YES
OPENSC_CONF_OPTS = --disable-cmocka --disable-strict --disable-tests

ifeq ($(BR2_PACKAGE_OPENSSL),y)
OPENSC_DEPENDENCIES += openssl
OPENSC_CONF_OPTS += --enable-openssl
else
OPENSC_CONF_OPTS += --disable-openssl
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
OPENSC_DEPENDENCIES += zlib
OPENSC_CONF_OPTS += --enable-zlib
else
OPENSC_CONF_OPTS += --disable-zlib
endif

$(eval $(autotools-package))
