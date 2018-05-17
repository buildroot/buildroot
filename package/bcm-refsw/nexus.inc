define BCM_REFSW_BUILD_NEXUS
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(@D)/nexus/build all \
			$(BCM_REFSW_BUILD_ADDITIONS)
endef

define BCM_REFSW_INSTALL_NEXUS
	$(INSTALL) -m 750 -D $(BCM_REFSW_BIN)/nexus $(1)/sbin/nexus
	$(INSTALL) -m 644 -D $(BCM_REFSW_BIN)/nexus.ko $(1)/lib/modules/nexus.ko
	$(INSTALL) -D -m 755 package/bcm-refsw/S11nexus $(1)/etc/init.d/S11nexus
	$(INSTALL) -D $(BCM_REFSW_BIN)/libnexus.so $(1)/usr/lib/libnexus.so
endef

define BCM_REFSW_INSTALL_NEXUS_DEV
	$(call BCM_REFSW_INSTALL_NEXUS,$(STAGING_DIR))
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/refsw
	$(INSTALL) -m 644 $(BCM_REFSW_BIN)/include/*.h $(STAGING_DIR)/usr/include/refsw/
	$(INSTALL) -m 644 $(BCM_REFSW_OUTPUT)/nexus/bin/include/*.h $(STAGING_DIR)/usr/include/refsw/
	$(INSTALL) -m 644 $(BCM_REFSW_BIN)/include/platform_app.inc $(STAGING_DIR)/usr/include/
endef

ifeq ($(BR2_PACKAGE_BCM_REFSW_PMLIB),y)
define BCM_REFSW_BUILD_PMLIB
    $(TARGET_CONFIGURE_OPTS) \
    $(TARGET_MAKE_ENV) \
    $(BCM_REFSW_CONF_OPTS) \
    $(BCM_REFSW_MAKE_ENV) \
        $(MAKE) -C $(@D)/BSEAV/lib/pmlib \
            LIBDIR=${BCM_REFSW_BIN}
endef

define BCM_REFSW_INSTALL_PMLIB_DEV
	$(INSTALL) -m 644 -D $(BCM_REFSW_OUTPUT)/BSEAV/lib/pmlib/libpmlib.a $(STAGING_DIR)/usr/lib/libpmlib.a
	$(INSTALL) -m 644 $(BCM_REFSW_DIR)/BSEAV/lib/pmlib/$(BCM_PMLIB_VERSION)/pmlib.h $(STAGING_DIR)/usr/include/refsw
endef
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW_EGLCUBE),y)
ifeq ($(shell expr $(BCM_REFSW_VERSION) \>= 17.1),1)
BCM_CUBE_DIR = /BSEAV/lib/gpu/applications/nexus/cube
else
BCM_CUBE_DIR = /rockford/applications/khronos/v3d/nexus/cube
endif

define BCM_REFSW_BUILD_EGLCUBE
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
               $(MAKE) -C $(@D)/$(BCM_CUBE_DIR) \
			LIBDIR=${BCM_REFSW_BIN}
endef
endif

ifeq ($(BCM_REFSW_PLATFORM_VC),vc5)
define BCM_REFSW_INSTALL_WAKEUP
	$(INSTALL) -D -m 755 package/bcm-refsw/S11wakeup $1/etc/init.d/S11wakeup
	$(INSTALL) -m 644 -D $(BCM_REFSW_BIN)/wakeup_drv.ko $1/lib/modules/wakeup_drv.ko
endef
endif


define BCM_REFSW_BUILD_NEXUS_LIBB_OS
    $(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(@D)/nexus/lib/os all \
			$(BCM_REFSW_BUILD_ADDITIONS)
endef

define BCM_REFSW_INSTALL_NEXUS_LIBB_OS
	$(INSTALL) -D $(BCM_REFSW_BIN)/libb_os.so $(1)/usr/lib/libb_os.so
endef

define BCM_REFSW_INSTALL_NEXUS_LIBB_OS_DEV
	$(INSTALL) -m 755 -d $(1)/usr/include/refsw/os
	$(call BCM_REFSW_INSTALL_NEXUS_LIBB_OS,$(STAGING_DIR))
	cp -a $(@D)/nexus/lib/os/include/* $(1)/usr/include/refsw/os
endef
