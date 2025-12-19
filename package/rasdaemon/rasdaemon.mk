################################################################################
#
# rasdaemon
#
################################################################################

RASDAEMON_VERSION = 0.8.4
RASDAEMON_SITE = $(call github,mchehab,rasdaemon,v$(RASDAEMON_VERSION))
RASDAEMON_LICENSE = GPL-2.0+
RASDAEMON_LICENSE_FILES = COPYING
RASDAEMON_AUTORECONF = YES

RASDAEMON_DEPENDENCIES = libtraceevent
# rasdaemon uses argp.h which is not provided by uclibc or musl by default.
# Use the argp-standalone package to provide this.
ifeq ($(BR2_PACKAGE_ARGP_STANDALONE),y)
RASDAEMON_DEPENDENCIES += argp-standalone
RASDAEMON_CONF_ENV += LIBS="-largp"
endif

ifeq ($(BR2_PACKAGE_SQLITE),y)
RASDAEMON_CONF_OPTS += --enable-sqlite3
RASDAEMON_DEPENDENCIES += sqlite
else
RASDAEMON_CONF_OPTS += --disable-sqlite3
endif

ifeq ($(BR2_PACKAGE_RASDAEMON_AER),y)
RASDAEMON_DEPENDENCIES += pciutils
RASDAEMON_CONF_OPTS += --enable-aer
else
RASDAEMON_CONF_OPTS += --disable-aer
endif

define RASDAEMON_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/rasdaemon/S95rasdaemon \
		$(TARGET_DIR)/etc/init.d/S95rasdaemon
endef

$(eval $(autotools-package))
