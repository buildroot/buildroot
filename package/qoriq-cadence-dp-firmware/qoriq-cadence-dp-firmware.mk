################################################################################
#
# qoriq-cadence-dp-firmware
#
################################################################################

QORIQ_CADENCE_DP_FIRMWARE_VERSION = lsdk2012
QORIQ_CADENCE_DP_FIRMWARE_SITE = http://www.nxp.com/lgfiles/sdk/$(QORIQ_CADENCE_DP_FIRMWARE_VERSION)
QORIQ_CADENCE_DP_FIRMWARE_SOURCE = firmware-cadence-$(QORIQ_CADENCE_DP_FIRMWARE_VERSION).bin
QORIQ_CADENCE_DP_FIRMWARE_LICENSE = NXP Semiconductor Software License Agreement
QORIQ_CADENCE_DP_FIRMWARE_LICENSE_FILES = COPYING EULA EULA.txt
QORIQ_CADENCE_DP_FIRMWARE_REDISTRIBUTE = NO
QORIQ_CADENCE_DP_FIRMWARE_INSTALL_IMAGES = YES
ifeq ($(BR2_LINUX_KERNEL_INSTALL_TARGET),)
QORIQ_CADENCE_DP_FIRMWARE_INSTALL_TARGET = NO
endif

define QORIQ_CADENCE_DP_FIRMWARE_EXTRACT_CMDS
	$(call NXP_EXTRACT_HELPER,$(QORIQ_CADENCE_DP_FIRMWARE_DL_DIR)/$(QORIQ_CADENCE_DP_FIRMWARE_SOURCE))
endef

define QORIQ_CADENCE_DP_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/dp/ls1028a-dp-fw.bin $(TARGET_DIR)/boot/ls1028a-dp-fw.bin
endef

define QORIQ_CADENCE_DP_FIRMWARE_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/dp/ls1028a-dp-fw.bin $(BINARIES_DIR)/ls1028a-dp-fw.bin
endef

$(eval $(generic-package))
