################################################################################
#
# rpi-wifi-firmware
#
################################################################################

RPI_WIFI_FIRMWARE_VERSION = 927fa8ebdf5bcfb90944465b40ec4981e01d6015
RPI_WIFI_FIRMWARE_SITE = $(call github,RPi-Distro,firmware-nonfree,$(RPI_WIFI_FIRMWARE_VERSION))
RPI_WIFI_FIRMWARE_LICENSE = Proprietary
RPI_WIFI_FIRMWARE_LICENSE_FILES = LICENCE.broadcom_bcm43xx

define RPI_WIFI_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/brcm/brcmfmac43143.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43143.bin
	$(INSTALL) -D -m 0644 $(@D)/brcm/brcmfmac43430-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.bin
	$(INSTALL) -D -m 0644 $(@D)/brcm/brcmfmac43430-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.txt
endef

$(eval $(generic-package))
