################################################################################
#
# bcm-wifi-dhd
#
################################################################################

BCM_WIFI_DHD_VERSION = 85e9e8cb7bcc3512d6437bb1d88912070f2d15c9
BCM_WIFI_DHD_SITE = git@github.com:Metrological/bcm-wifi-dhd.git
BCM_WIFI_DHD_SITE_METHOD = git
BCM_WIFI_DHD_LICENSE = PROPRIETARY
BCM_WIFI_DHD_INSTALL_STAGING = YES
BCM_WIFI_DHD_DEPENDENCIES = linux

STBSTA_WIFI_DHD_DRIVER="dhd-msgbuf-pciefd-media-mfp-wet-cfg80211-armv7l"

define BCM_WIFI_DHD_BUILD_CMDS
	$(MAKE) \
	LINUXDIR=$(LINUX_DIR) \
	CROSS_COMPILE=arm-buildroot-linux-gnueabihf- -C $(@D)/src/dhd/linux $(STBSTA_WIFI_DHD_DRIVER)
endef

define BCM_WIFI_DHD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 644 $(@D)/src/dhd/linux/$(STBSTA_WIFI_DHD_DRIVER)-$(LINUX_VERSION_PROBED)/dhd.ko $(TARGET_DIR)/lib/modules/dhd.ko
	$(INSTALL) -D -m 644 $(@D)/firmware/bcm43570a2.bin $(TARGET_DIR)/lib/firmware/bcm43570a2.bin
	$(INSTALL) -D -m 644 $(@D)/nvram/bcm43570a2.nvm $(TARGET_DIR)/etc/nvram/bcm43570a2.nvm
	$(INSTALL) -D -m 755 package/bcm-wifi-dhd/S12wifidriver $(TARGET_DIR)/etc/init.d/S12wifidriver
endef

$(eval $(generic-package))
