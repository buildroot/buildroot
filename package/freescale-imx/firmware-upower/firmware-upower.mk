################################################################################
#
# firmware-ele-imx
#
################################################################################

FIRMWARE_UPOWER_VERSION = 1.3.1
FIRMWARE_UPOWER_SITE = $(FREESCALE_IMX_SITE)
FIRMWARE_UPOWER_SOURCE = firmware-upower-$(FIRMWARE_UPOWER_VERSION).bin

FIRMWARE_UPOWER_LICENSE = NXP Semiconductor Software License Agreement
FIRMWARE_UPOWER_LICENSE_FILES = COPYING EULA
FIRMWARE_UPOWER_REDISTRIBUTE = NO

FIRMWARE_UPOWER_INSTALL_IMAGES = YES

define FIRMWARE_UPOWER_EXTRACT_CMDS
	$(call NXP_EXTRACT_HELPER,$(FIRMWARE_UPOWER_DL_DIR)/$(FIRMWARE_UPOWER_SOURCE))
endef

FIRMWARE_UPOWER_UPOWER_FIRMWARE_NAME = $(call qstrip,$(BR2_PACKAGE_FIRMWARE_UPOWER_UPOWER_FIRMWARE_NAME))

define FIRMWARE_UPOWER_INSTALL_IMAGES_CMDS
	cp $(@D)/$(FIRMWARE_UPOWER_UPOWER_FIRMWARE_NAME) $(BINARIES_DIR)/upower.bin
endef

$(eval $(generic-package))
