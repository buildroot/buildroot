################################################################################
#
# pound
#
################################################################################

POUND_VERSION = 4.8
POUND_SITE = https://github.com/graygnuorg/pound/releases/download/v$(POUND_VERSION)
POUND_LICENSE = GPL-3.0+
POUND_LICENSE_FILES = COPYING
POUND_DEPENDENCIES = openssl host-openssl

# Force owner/group to us, otherwise it will try proxy:proxy by
# default.
POUND_CONF_OPTS = \
	--with-owner=$(shell id -un) \
	--with-group=$(shell id -gn)

ifeq ($(BR2_PACKAGE_PCRE2),y)
POUND_CONF_OPTS += --enable-pcreposix=pcre2
POUND_CONF_ENV += \
	ac_cv_path_PCRE2_CONFIG=$(STAGING_DIR)/usr/bin/pcre2-config
POUND_DEPENDENCIES += pcre2
else ifeq ($(BR2_PACKAGE_PCRE),y)
POUND_CONF_OPTS += --enable-pcreposix=pcre1
POUND_DEPENDENCIES += pcre
else
POUND_CONF_OPTS += --disable-pcreposix
endif

$(eval $(autotools-package))
