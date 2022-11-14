################################################################################
#
# armbian-firmware
#
################################################################################

ARMBIAN_FIRMWARE_VERSION = 5d685ad233b4dfd03a4d025fa0061f6b0f850cb3
ARMBIAN_FIRMWARE_SITE = https://github.com/armbian/firmware
ARMBIAN_FIRMWARE_SITE_METHOD = git

# AP6212 WiFi/BT combo firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_AP6212),y)
ARMBIAN_FIRMWARE_DIRS += ap6212
endif

# AP6256 WiFi/BT combo firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_AP6256),y)
ARMBIAN_FIRMWARE_FILES += \
	brcm/BCM4345C5.hcd \
	brcm/brcmfmac43456-sdio.bin \
	brcm/brcmfmac43456-sdio.txt
endif

# AP6255 WiFi/BT combo firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_AP6255),y)
ARMBIAN_FIRMWARE_FILES += \
	BCM4345C0.hcd \
	fw_bcm43455c0_ag.bin \
	fw_bcm43455c0_ag_apsta.bin \
	fw_bcm43455c0_ag_p2p.bin \
	nvram_ap6255.txt \
	brcm/brcmfmac43455-sdio.bin \
	brcm/brcmfmac43455-sdio.clm_blob \
	brcm/brcmfmac43455-sdio.txt \
	brcm/config.txt
endif

# Realtek 8822CS SDIO WiFi/BT combo firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_RTL8822CS),y)
ARMBIAN_FIRMWARE_FILES += \
	rtlbt/rtl8822cs_config \
	rtlbt/rtl8822cs_fw \
	rtl_bt/rtl8822cs_config.bin \
	rtl_bt/rtl8822cs_fw.bin
endif

# XR819 WiFi firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_XR819),y)
ARMBIAN_FIRMWARE_FILES += \
	xr819/boot_xr819.bin \
	xr819/fw_xr819.bin \
	xr819/sdd_xr819.bin
endif

ifneq ($(ARMBIAN_FIRMWARE_FILES),)
define ARMBIAN_FIRMWARE_INSTALL_FILES
	cd $(@D) && \
		$(TAR) cf install.tar $(sort $(ARMBIAN_FIRMWARE_FILES)) && \
		$(TAR) xf install.tar -C $(TARGET_DIR)/lib/firmware
endef
endif

ifneq ($(ARMBIAN_FIRMWARE_DIRS),)
# We need to rm -rf the destination directory to avoid copying
# into it in itself, should we re-install the package.
define ARMBIAN_FIRMWARE_INSTALL_DIRS
	$(foreach d,$(ARMBIAN_FIRMWARE_DIRS), \
		rm -rf $(TARGET_DIR)/lib/firmware/$(d); \
		cp -a $(@D)/$(d) $(TARGET_DIR)/lib/firmware/$(d)$(sep))
endef
endif

ifneq ($(ARMBIAN_FIRMWARE_FILES)$(ARMBIAN_FIRMWARE_DIRS),)
ARMBIAN_FIRMWARE_LICENSE = PROPRIETARY
ARMBIAN_FIRMWARE_REDISTRIBUTE = NO
endif

define ARMBIAN_FIRMWARE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware
	$(ARMBIAN_FIRMWARE_INSTALL_FILES)
	$(ARMBIAN_FIRMWARE_INSTALL_DIRS)
endef

$(eval $(generic-package))
