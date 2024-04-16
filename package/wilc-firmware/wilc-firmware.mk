################################################################################
#
# wilc-firmware
#
################################################################################

WILC_FIRMWARE_VERSION = wilc_linux_16_1_2
WILC_FIRMWARE_SITE = $(call github,linux4wilc,firmware,$(WILC_FIRMWARE_VERSION))

WILC_FIRMWARE_LICENSE = PROPRIETARY
WILC_FIRMWARE_LICENSE_FILES = LICENSE.wilc_fw

ifeq ($(BR2_PACKAGE_WILC1000_FIRMWARE),y)
WILC_FIRMWARE_FILES += \
	wilc1000_wifi_firmware.bin
endif

ifeq ($(BR2_PACKAGE_WILC3000_FIRMWARE),y)
WILC_FIRMWARE_FILES += \
	wilc3000_ble_firmware.bin \
	wilc3000_wifi_firmware.bin
endif

define WILC_FIRMWARE_INSTALL_FILES
	cd $(@D) && \
		$(TAR) cf install.tar $(sort $(WILC_FIRMWARE_FILES)) && \
		$(TAR) xf install.tar -C $(TARGET_DIR)/lib/firmware/mchp
endef

define WILC_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/lib/firmware/mchp/
	$(WILC_FIRMWARE_INSTALL_FILES)
endef

$(eval $(generic-package))
