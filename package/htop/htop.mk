################################################################################
#
# htop
#
################################################################################

HTOP_VERSION = 3.1.2
HTOP_SITE = $(call github,htop-dev,htop,$(HTOP_VERSION))
HTOP_DEPENDENCIES = ncurses
HTOP_AUTORECONF = YES
# Prevent htop build system from searching the host paths
HTOP_CONF_ENV = HTOP_NCURSES_CONFIG_SCRIPT=$(STAGING_DIR)/usr/bin/$(NCURSES_CONFIG_SCRIPTS)
HTOP_LICENSE = GPL-2.0+
HTOP_LICENSE_FILES = COPYING

ifeq ($(BR2_PACKAGE_HWLOC),y)
HTOP_CONF_OPTS += --enable-hwloc
HTOP_DEPENDENCIES += hwloc
else
HTOP_CONF_OPTS += --disable-hwloc
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
HTOP_CONF_OPTS += --enable-capabilities
HTOP_DEPENDENCIES += libcap
else
HTOP_CONF_OPTS += --disable-capabilities
endif

ifeq ($(BR2_PACKAGE_LM_SENSORS),y)
HTOP_CONF_OPTS += --with-sensors
HTOP_DEPENDENCIES += lm-sensors
else
HTOP_CONF_OPTS += --without-sensors
endif

ifeq ($(BR2_PACKAGE_NCURSES_WCHAR),y)
HTOP_CONF_OPTS += --enable-unicode
else
HTOP_CONF_OPTS += --disable-unicode
endif

$(eval $(autotools-package))
