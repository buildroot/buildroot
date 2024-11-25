################################################################################
#
# tig
#
################################################################################

TIG_VERSION = 2.5.10
TIG_SITE = https://github.com/jonas/tig/releases/download/tig-$(TIG_VERSION)
TIG_LICENSE = GPL-2.0+
TIG_LICENSE_FILES = COPYING

TIG_DEPENDENCIES = ncurses

ifeq ($(BR2_PACKAGE_LIBICONV),y)
TIG_DEPENDENCIES += libiconv
TIG_CONF_OPTS += --with-iconv=$(STAGING_DIR)/usr
else
TIG_CONF_OPTS += --without-iconv
endif

$(eval $(autotools-package))
