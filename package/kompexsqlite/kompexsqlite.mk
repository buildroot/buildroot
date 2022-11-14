################################################################################
#
# kompexsqlite
#
################################################################################

KOMPEXSQLITE_VERSION = 1.12.15
KOMPEXSQLITE_SOURCE = download.php?dl=KompexSQLiteWrapper-Source_$(KOMPEXSQLITE_VERSION).tar.gz
KOMPEXSQLITE_SITE = http://sqlitewrapper.kompex-online.com/counter
KOMPEXSQLITE_INSTALL_STAGING = YES
KOMPEXSQLITE_LICENSE = MIT (wrapper), Public Domain (bundled sqlite)
KOMPEXSQLITE_LICENSE_FILES = inc/KompexSQLiteDatabase.h inc/sqlite3.h

ifeq ($(BR2_STATIC_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
KOMPEXSQLITE_CONFS += ReleaseStaticLib
define KOMPEXSQLITE_INSTALL_STATIC_LIB
	$(INSTALL) -D -m 0644 $(@D)/lib/release/KompexSQLiteWrapper_Static.a \
		$(STAGING_DIR)/usr/lib/libkompex-sqlite-wrapper.a
endef
endif

ifeq ($(BR2_SHARED_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
KOMPEXSQLITE_CONFS += ReleaseDynamicLib
define KOMPEXSQLITE_INSTALL_SHARED_LIB
	$(INSTALL) -D -m 0755 $(@D)/lib/release/KompexSQLiteWrapper.so \
		$(1)/usr/lib/libkompex-sqlite-wrapper.so
endef
endif

define KOMPEXSQLITE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		ALLCONFS="$(KOMPEXSQLITE_CONFS)" \
		-C "$(@D)/Kompex SQLite Wrapper" all
endef

define KOMPEXSQLITE_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include/kompex
	$(INSTALL) -m 644 $(@D)/inc/* $(STAGING_DIR)/usr/include/kompex
	$(KOMPEXSQLITE_INSTALL_STATIC_LIB)
	$(call KOMPEXSQLITE_INSTALL_SHARED_LIB,$(STAGING_DIR))
endef

define KOMPEXSQLITE_INSTALL_TARGET_CMDS
	$(call KOMPEXSQLITE_INSTALL_SHARED_LIB,$(TARGET_DIR))
endef

$(eval $(generic-package))
