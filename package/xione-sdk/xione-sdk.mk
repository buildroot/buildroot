################################################################################
#
# xione-sdk
#
################################################################################
XIONE_SDK_VERSION = main
XIONE_SDK_SITE = git@github.com:Metrological/SDK_XiOne.git
XIONE_SDK_SITE_METHOD = git
XIONE_SDK_LICENSE = CLOSED
XIONE_SDK_INSTALL_STAGING = YES
XIONE_SDK_INSTALL_TARGET = YES
XIONE_SDK_DEPENDENCIES = libdrm wayland

define XIONE_SDK_PERMISSIONS
endef

define XIONE_SDK_INSTALL_PREBUILD_HOST_TOOLS
    cp -av $(@D)/host-tools/verity $(1)
    cp -av $(@D)/host-tools/image $(1)
endef

define XIONE_SDK_INSTALL_PREBUILD_RTK_TEE
    cp -Rpf $(@D)/prebuilds/rtk-tee/usr/bin $(1)/usr
    cp -Rpf $(@D)/prebuilds/rtk-tee/usr/lib $(1)/usr
    cp -Rpf $(@D)/prebuilds/rtk-tee/tas $(1)
    ln -sf ../tas $(1)/lib/teetz
endef

define XIONE_SDK_INSTALL_PREBUILD_RTK_TEE_DEV
    $(call XIONE_SDK_INSTALL_PREBUILD_RTK_TEE,$(1))
    cp -Rpf $(@D)/prebuilds/rtk-tee/usr/include $(1)/usr
endef

define XIONE_SDK_INSTALL_PREBUILD_PLATFORM_LIB
    cp -Rpf $(@D)/prebuilds/platform_lib/usr/bin $(1)/usr
    cp -Rpf $(@D)/prebuilds/platform_lib/usr/sbin $(1)/usr
    cp -Rpf $(@D)/prebuilds/platform_lib/usr/lib $(1)/usr
    cp -Rpf $(@D)/prebuilds/platform_lib/system $(1)
endef

define XIONE_SDK_INSTALL_PREBUILD_PLATFORM_LIB_DEV
    $(call XIONE_SDK_INSTALL_PREBUILD_PLATFORM_LIB,$(1))
    cp -Rpf $(@D)/prebuilds/platform_lib/usr/include $(1)/usr
endef

define XIONE_SDK_INSTALL_PREBUILD_HDMISERVICE
    cp -Rpf $(@D)/prebuilds/hdmiservice/usr/lib $(1)/usr
    cp -Rpf $(@D)/prebuilds/hdmiservice/usr/bin $(1)/usr
endef

define XIONE_SDK_INSTALL_PREBUILD_HDMISERVICE_DEV
    $(call XIONE_SDK_INSTALL_PREBUILD_HDMISERVICE,$(1))
    cp -Rpf $(@D)/prebuilds/hdmiservice/usr/include $(1)/usr
endef

define XIONE_SDK_INSTALL_PREBUILD_MALI_LIB
    cp -Rpf $(@D)/prebuilds/mali/lib/* $(1)/usr/lib/
endef

define XIONE_SDK_INSTALL_PREBUILD_MALI_DEV
    $(call XIONE_SDK_INSTALL_PREBUILD_MALI_LIB,$(1))
    cp -Rpf $(@D)/prebuilds/mali/include/* $(1)/usr/include/
endef

define XIONE_SDK_INSTALL_PREBUILD_MFR_LIB
    cp -Rpf $(@D)/prebuilds/mfrlib/* $(1)/usr/lib/
endef

define XIONE_SDK_INSTALL_PREBUILD_XSIGN_LIB
    cp -Rpf $(@D)/prebuilds/xsign/* $(1)/usr/lib/
endef

define XIONE_SDK_INSTALL_PREBUILD_MALI_DRIVER
    cp -Rpf $(@D)/prebuilds/hank-mod-mali/* $(1)
endef

define XIONE_SDK_INSTALL_PREBUILD_GENERIC_DRIVERS
    cp -Rpf $(@D)/prebuilds/linux-hank/* $(1)
endef

define XIONE_SDK_INSTALL_PREBUILD_RF4CE_DRIVER
    cp -Rpf $(@D)/prebuilds/qorvo-mod-rf4ce/* $(1)
endef

define XIONE_SDK_INSTALL_PREBUILD_WIFI_DRIVER
    cp -Rpf $(@D)/prebuilds/qca6390-mod-wifi/* $(1)
endef

define XIONE_SDK_INSTALL_STAGING_CMDS
    $(call XIONE_SDK_INSTALL_PREBUILD_GENERIC_DRIVERS,$(STAGING_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_MALI_DRIVER,$(STAGING_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_RF4CE_DRIVER,$(STAGING_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_WIFI_DRIVER,$(STAGING_DIR))

    $(call XIONE_SDK_INSTALL_PREBUILD_MALI_DEV,$(STAGING_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_PLATFORM_LIB_DEV,$(STAGING_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_MFR_LIB,$(STAGING_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_XSIGN_LIB,$(STAGING_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_RTK_TEE_DEV,$(STAGING_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_HDMISERVICE_DEV,$(STAGING_DIR))
    
endef

define XIONE_SDK_INSTALL_TARGET_CMDS
    $(call XIONE_SDK_INSTALL_PREBUILD_GENERIC_DRIVERS,$(TARGET_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_MALI_DRIVER,$(TARGET_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_RF4CE_DRIVER,$(TARGET_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_WIFI_DRIVER,$(TARGET_DIR))

    $(call XIONE_SDK_INSTALL_PREBUILD_MALI_LIB,$(TARGET_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_PLATFORM_LIB,$(TARGET_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_MFR_LIB,$(TARGET_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_XSIGN_LIB,$(TARGET_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_RTK_TEE,$(TARGET_DIR))
    $(call XIONE_SDK_INSTALL_PREBUILD_HDMISERVICE,$(TARGET_DIR))

    
    
endef

define QORVO_BUILD_MODULE
    CFLAGS = \
     -DGP501 \
     -DGP_USE_NEXUS_SPI \
     -nodefaultlibs \
     -Wno-unused-variable \
     -Wno-incompatible-pointer-types \
     -I$(STAGING_DIR)/usr/include \
     -I$(STAGING_DIR)/usr/include/linux \
     -I$(STAGING_DIR)/usr/include/refsw/ \
     -I$(STAGING_DIR)/usr/include/refsw/linuxkernel/include/ \
     -I${@D}/Driver/BCM97358Ref \
     $(MAKE) -C $(LINUX_DIR) $(LINUX_MAKE_FLAGS) GP_CHIP=$(GREENPEAK_CHIP) EXTRA_CFLAGS="$(GREENPEAK_EXTRA_MOD_CFLAGS)" M=$(@D)/Driver modules
endef

define QORVO_INSTALL_MODULE
    $(MAKE) -C $(LINUX_DIR) $(LINUX_MAKE_FLAGS) M=$(@D)/Driver modules_install
endef

$(eval $(generic-package))
