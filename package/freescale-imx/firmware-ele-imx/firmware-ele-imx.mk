################################################################################
#
# firmware-ele-imx
#
################################################################################

FIRMWARE_ELE_IMX_VERSION = 2.0.1
FIRMWARE_ELE_IMX_REVISION = 0a66c34
FIRMWARE_ELE_IMX_SITE = $(FREESCALE_IMX_SITE)
FIRMWARE_ELE_IMX_SOURCE = firmware-ele-imx-$(FIRMWARE_ELE_IMX_VERSION)-$(FIRMWARE_ELE_IMX_REVISION).bin

FIRMWARE_ELE_IMX_LICENSE = NXP Semiconductor Software License Agreement
FIRMWARE_ELE_IMX_LICENSE_FILES = COPYING EULA SCR.txt
FIRMWARE_ELE_IMX_REDISTRIBUTE = NO

FIRMWARE_ELE_IMX_INSTALL_IMAGES = YES

define FIRMWARE_ELE_IMX_EXTRACT_CMDS
	$(call NXP_EXTRACT_HELPER,$(FIRMWARE_ELE_IMX_DL_DIR)/$(FIRMWARE_ELE_IMX_SOURCE))
endef

FIRMWARE_ELE_IMX_AHAB_CONTAINER_IMAGE = $(call qstrip,$(BR2_PACKAGE_FIRMWARE_ELE_IMX_AHAB_CONTAINER_IMAGE))

define FIRMWARE_ELE_IMX_INSTALL_IMAGES_CMDS
	cp $(@D)/$(FIRMWARE_ELE_IMX_AHAB_CONTAINER_IMAGE) $(BINARIES_DIR)/ahab-container.img
endef

$(eval $(generic-package))
