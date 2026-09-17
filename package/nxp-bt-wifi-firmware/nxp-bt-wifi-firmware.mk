################################################################################
#
# nxp-bt-wifi-firmware
#
################################################################################

NXP_BT_WIFI_FIRMWARE_VERSION = lf-6.18.20-2.0.0
NXP_BT_WIFI_FIRMWARE_SITE = $(call github,nxp-imx,imx-firmware,$(NXP_BT_WIFI_FIRMWARE_VERSION))
NXP_BT_WIFI_FIRMWARE_LICENSE = NXP Software License Agreement
NXP_BT_WIFI_FIRMWARE_LICENSE_FILES = LICENSE.txt
NXP_BT_WIFI_FIRMWARE_REDISTRIBUTE = NO

NXP_BT_WIFI_FIRMWARE_FILES_$(BR2_PACKAGE_NXP_BT_WIFI_FIRMWARE_8987) += FwImage_8987_SD
NXP_BT_WIFI_FIRMWARE_FILES_$(BR2_PACKAGE_NXP_BT_WIFI_FIRMWARE_9098_SD) += FwImage_9098_SD
NXP_BT_WIFI_FIRMWARE_FILES_$(BR2_PACKAGE_NXP_BT_WIFI_FIRMWARE_9098_PCIE) += FwImage_9098_PCIE
NXP_BT_WIFI_FIRMWARE_FILES_$(BR2_PACKAGE_NXP_BT_WIFI_FIRMWARE_IW416) += FwImage_IW416_SD
NXP_BT_WIFI_FIRMWARE_FILES_$(BR2_PACKAGE_NXP_BT_WIFI_FIRMWARE_IW610_SD) += FwImage_IW610_SD
NXP_BT_WIFI_FIRMWARE_FILES_$(BR2_PACKAGE_NXP_BT_WIFI_FIRMWARE_IW610_USB) += FwImage_IW610_USB
NXP_BT_WIFI_FIRMWARE_FILES_$(BR2_PACKAGE_NXP_BT_WIFI_FIRMWARE_IW612) += FwImage_IW612_SD

define NXP_BT_WIFI_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 -D $(@D)/wifi_mod_para.conf \
		$(TARGET_DIR)/lib/firmware/nxp/wifi_mod_para.conf
	$(INSTALL) -m 0644 -D $(@D)/mfguart/helper_uart_3000000.bin \
		$(TARGET_DIR)/lib/firmware/nxp/helper_uart_3000000.bin
	$(foreach f,$(NXP_BT_WIFI_FIRMWARE_FILES_y), \
		$(INSTALL) -m 0644 -D $(@D)/$(f)/* $(TARGET_DIR)/lib/firmware/nxp/
	)
endef

$(eval $(generic-package))
