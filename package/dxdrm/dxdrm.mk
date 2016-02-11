################################################################################
#
# dxdrm
#
################################################################################

DXDRM_VERSION = 44c1cf3dca6d203c1a92fb4425ce02e99494f686
DXDRM_SITE_METHOD = git
DXDRM_SITE = git@github.com:Metrological/dxdrm.git
DXDRM_LICENSE = PROPRIETARY
DXDRM_REDISTRIBUTE = NO

DXDRM_INSTALL_STAGING = YES

DXDRM_DEPENDENCIES += libcurl

ifeq ($(BR2_PACKAGE_DXDRM_EXTERNAL),y)
DXDRM_DEPENDENCIES += libprovision
DXDRM_LOCATOR = external
else
DXDRM_LOCATOR = internal
endif

define DXDRM_INSTALL_STAGING_CMDS
	$(INSTALL) -m 755 $(@D)/$(DXDRM_LOCATOR)/$(call qstrip,$(BR2_ARCH))/release/libDxDrm.so $(STAGING_DIR)/usr/lib/libDxDrm.so
	$(INSTALL) -m 755 $(@D)/$(DXDRM_LOCATOR)/$(call qstrip,$(BR2_ARCH))/release/libTrusted.so $(STAGING_DIR)/usr/lib/libTrusted.so
	$(INSTALL) -d -m 755 $(STAGING_DIR)/usr/include/dxdrm
	$(INSTALL) -m 644 $(@D)/$(DXDRM_LOCATOR)/include/*.h $(STAGING_DIR)/usr/include/dxdrm
	$(INSTALL) -m 644 $(@D)/external/dxdrm.pc $(STAGING_DIR)/usr/lib/pkgconfig
endef

define DXDRM_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/$(DXDRM_LOCATOR)/$(call qstrip,$(BR2_ARCH))/release/libDxDrm.so $(TARGET_DIR)/usr/lib/libDxDrm.so
	$(INSTALL) -m 755 $(@D)/$(DXDRM_LOCATOR)/$(call qstrip,$(BR2_ARCH))/release/libTrusted.so $(TARGET_DIR)/usr/lib/libTrusted.so
	$(INSTALL) -d -m 755 $(TARGET_DIR)/etc/dxdrm
	$(INSTALL) -m 644 $(@D)/$(DXDRM_LOCATOR)/dxdrm.config $(TARGET_DIR)/etc/dxdrm
	if [ "x$(BR2_PACKAGE_DXDRM_INTERNAL)" = "xy" ]; then \
		$(INSTALL) -m 644 $(@D)/$(DXDRM_LOCATOR)/credentials/* $(TARGET_DIR)/etc/dxdrm; \
	fi
endef

$(eval $(generic-package))
