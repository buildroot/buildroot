################################################################################
#
# brcmfmac_sdio-firmware-rpi
#
################################################################################

BRCMFMAC_SDIO_FIRMWARE_RPI_VERSION = ea9963f3f77b4bb6cd280577eb115152bdd67e8d
BRCMFMAC_SDIO_FIRMWARE_RPI_SITE = $(call github,LibreELEC,brcmfmac_sdio-firmware-rpi,$(BRCMFMAC_SDIO_FIRMWARE_RPI_VERSION))
BRCMFMAC_SDIO_FIRMWARE_RPI_LICENSE = PROPRIETARY
BRCMFMAC_SDIO_FIRMWARE_RPI_LICENSE_FILES = LICENCE.broadcom_bcm43xx

ifeq ($(BR2_PACKAGE_BRCMFMAC_SDIO_FIRMWARE_RPI_BT),y)
define BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_BT
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/brcm
	$(INSTALL) -m 0644 $(@D)/firmware/brcm/*.hcd $(TARGET_DIR)/lib/firmware/brcm
endef
endif

ifeq ($(BR2_PACKAGE_BRCMFMAC_SDIO_FIRMWARE_RPI_WIFI),y)
define BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_WIFI
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/brcm
	$(INSTALL) -m 0644 $(@D)/firmware/brcm/brcmfmac* $(TARGET_DIR)/lib/firmware/brcm
	ln -sf ../cypress/cyfmac43430-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.bin
	ln -sf ../cypress/cyfmac43430-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.clm_blob
	ln -sf brcmfmac43430-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.raspberrypi,3-model-b.txt
	ln -sf brcmfmac43430-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.raspberrypi,model-zero-w.txt
	ln -sf ../cypress/cyfmac43455-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.bin
	ln -sf ../cypress/cyfmac43455-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.clm_blob
	ln -sf brcmfmac43455-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,3-model-a-plus.txt
	ln -sf brcmfmac43455-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt
	ln -sf brcmfmac43455-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/cypress
	$(INSTALL) -m 0644 $(@D)/firmware/cypress/cyfmac* $(TARGET_DIR)/lib/firmware/cypress
endef
endif

define BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_CMDS
	$(BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_BT)
	$(BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_WIFI)
endef

$(eval $(generic-package))
