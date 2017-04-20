################################################################################
#
# rpi-wifi-firmware
#
################################################################################

RPI_WIFI_FIRMWARE_VERSION = a7491de4c4b2f1ceb5d0dfa5350b95e5c6fb9bd4
RPI_WIFI_FIRMWARE_SITE = $(call github,RPi-Distro,firmware-nonfree,$(RPI_WIFI_FIRMWARE_VERSION))
RPI_WIFI_FIRMWARE_LICENSE = Proprietary
RPI_WIFI_FIRMWARE_LICENSE_FILES = brcm80211/LICENSE

define RPI_WIFI_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/brcm80211/brcm/brcmfmac43143.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43143.bin
	$(INSTALL) -D -m 0644 $(@D)/brcm80211/brcm/brcmfmac43430-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.bin
	$(INSTALL) -D -m 0644 $(@D)/brcm80211/brcm/brcmfmac43430-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.txt
endef
 
$(eval $(generic-package))
