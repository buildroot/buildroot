################################################################################
#
# pound
#
################################################################################

POUND_VERSION = 4.17
POUND_SITE = https://github.com/graygnuorg/pound/releases/download/v$(POUND_VERSION)
POUND_LICENSE = GPL-3.0+
POUND_LICENSE_FILES = COPYING
POUND_DEPENDENCIES = openssl host-openssl

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
POUND_DEPENDENCIES += libxcrypt
endif

ifeq ($(BR2_PACKAGE_PCRE2),y)
POUND_CONF_OPTS += --enable-pcre=2
POUND_CONF_ENV += \
	ac_cv_path_PCRE2_CONFIG=$(STAGING_DIR)/usr/bin/pcre2-config
POUND_DEPENDENCIES += pcre2
else ifeq ($(BR2_PACKAGE_PCRE),y)
POUND_CONF_OPTS += --enable-pcre=1
POUND_DEPENDENCIES += pcre
else
POUND_CONF_OPTS += --disable-pcre
endif

$(eval $(autotools-package))
