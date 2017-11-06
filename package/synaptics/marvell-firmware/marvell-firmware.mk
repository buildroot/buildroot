################################################################################
#
# marvell-firmware
#
################################################################################

MARVELL_FIRMWARE_VERSION = 6a931a1021cb3a154e3e4a5cca71b8f96ae221ee
MARVELL_FIRMWARE_SITE_METHOD = git
MARVELL_FIRMWARE_SITE = git@github.com:Metrological/marvell-firmware.git

MARVELL_FIRMWARE_INSTALL_STAGING = YES
MARVELL_FIRMWARE_DEPENDENCIES = wayland marvell-ampsdk
MARVELL_FIRMWARE_LICENSE = CLOSED

define MARVELL_FIRMWARE_BUILD_CMDS
# no buildable targets yet.
endef

ifeq ($(BR2_PACKAGE_MARVELL_FIRMWARE_GFX),y)
define MARVELL_FIRMWARE_INSTALL_GFX_LIBS
   $(INSTALL) -D -m 644 $(@D)/runtime/linux-yocto/data/gfx_prebuilt/sdk/drivers/* $(1)/usr/lib
endef

define MARVELL_FIRMWARE_INSTALL_GFX_DEV
   cp -a $(@D)/runtime/linux-yocto/data/gfx_prebuilt/sdk/include/* $(1)/usr/include
   $(INSTALL) -D -m 644 $(@D)/runtime/linux-yocto/data/gfx_prebuilt/sdk/pkgconfig/* $(1)/usr/lib/pkgconfig
endef

endif

define MARVELL_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 -d $(TARGET_DIR)/usr/lib
	
	$(INSTALL) -D -m 644 $(@D)/runtime/linux-gtb/data/rootfs_gtb/lib/liblog.so $(TARGET_DIR)/usr/lib
    $(call MARVELL_FIRMWARE_INSTALL_GFX_LIBS,$(TARGET_DIR))
endef

define MARVELL_FIRMWARE_INSTALL_STAGING_CMDS
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/lib
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/lib/pkgconfig
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include
	

	$(INSTALL) -D -m 644 $(@D)/runtime/linux-gtb/data/rootfs_gtb/lib/liblog.so $(STAGING_DIR)/usr/lib
    $(call MARVELL_FIRMWARE_INSTALL_GFX_LIBS,$(STAGING_DIR))
    $(call MARVELL_FIRMWARE_INSTALL_GFX_DEV,$(STAGING_DIR))
endef

$(eval $(generic-package))
