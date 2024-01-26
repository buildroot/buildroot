################################################################################
#
# rlwrap
#
################################################################################

RLWRAP_VERSION = 0.46.1
RLWRAP_SITE = https://github.com/hanslub42/rlwrap/releases/download/$(RLWRAP_VERSION)
RLWRAP_LICENSE = GPL-2.0+
RLWRAP_LICENSE_FILES = AUTHORS COPYING

RLWRAP_DEPENDENCIES = readline

ifeq ($(BR2_PACKAGE_RLWRAP_SPY_ON_READLINE),y)
RLWRAP_CONF_OPTS += --enable-spy-on-readline
else
RLWRAP_CONF_OPTS += --disable-spy-on-readline
endif

ifeq ($(BR2_PACKAGE_RLWRAP_HOMEGROWN_REDISPLAY),y)
RLWRAP_CONF_OPTS += --enable-homegrown-redisplay
else
RLWRAP_CONF_OPTS += --disable-homegrown-redisplay
endif

ifeq ($(BR2_PACKAGE_RLWRAP_MULTIBYTE_AWARE),y)
RLWRAP_CONF_OPTS += --enable-multibyte-aware
else
RLWRAP_CONF_OPTS += --disable-multibyte-aware
endif

define RLWRAP_REMOVE_FILTERS
	$(RM) -rf $(TARGET_DIR)/usr/share/rlwrap/filters
endef
RLWRAP_POST_INSTALL_TARGET_HOOKS += RLWRAP_REMOVE_FILTERS

$(eval $(autotools-package))
