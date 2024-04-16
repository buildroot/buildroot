################################################################################
#
# brcmfmac_sdio-firmware-rpi
#
################################################################################

BRCMFMAC_SDIO_FIRMWARE_RPI_VERSION = 26ff205b45dc109b498a70aaf182804ad9dbfea5
BRCMFMAC_SDIO_FIRMWARE_RPI_SITE = $(call github,LibreELEC,brcmfmac_sdio-firmware-rpi,$(BRCMFMAC_SDIO_FIRMWARE_RPI_VERSION))
BRCMFMAC_SDIO_FIRMWARE_RPI_LICENSE = PROPRIETARY
BRCMFMAC_SDIO_FIRMWARE_RPI_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_BRCMFMAC_SDIO_FIRMWARE_RPI_BT),y)
define BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_BT
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/brcm $(TARGET_DIR)/lib/firmware/synaptics
	cp --remove-destination --no-dereference $(@D)/firmware/brcm/*.hcd $(TARGET_DIR)/lib/firmware/brcm
	cp --remove-destination --no-dereference $(@D)/firmware/synaptics/*.hcd $(TARGET_DIR)/lib/firmware/synaptics
	chmod 644 $(TARGET_DIR)/lib/firmware/brcm/*.hcd $(TARGET_DIR)/lib/firmware/synaptics/*.hcd
endef
endif

ifeq ($(BR2_PACKAGE_BRCMFMAC_SDIO_FIRMWARE_RPI_WIFI),y)
define BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_WIFI
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/brcm $(TARGET_DIR)/lib/firmware/cypress
	cp --remove-destination --no-dereference $(@D)/firmware/brcm/brcmfmac* $(TARGET_DIR)/lib/firmware/brcm
	cp --remove-destination --no-dereference $(@D)/firmware/cypress/cyfmac* $(TARGET_DIR)/lib/firmware/cypress
	chmod 644 $(TARGET_DIR)/lib/firmware/brcm/brcmfmac* $(TARGET_DIR)/lib/firmware/cypress/cyfmac*
endef
endif

define BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_CMDS
	$(BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_BT)
	$(BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_WIFI)
endef

$(eval $(generic-package))
