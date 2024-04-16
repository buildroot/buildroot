################################################################################
#
# rtl8723ds-bt
#
################################################################################

RTL8723DS_BT_VERSION = 14cedf3a9fec1aa8c500fa52f3e3acc433cbcf08
RTL8723DS_BT_SITE = $(call github,wsyco,RTL8723DS_BT_Linux,$(RTL8723DS_BT_VERSION))
RTL8723DS_BT_LICENSE = PROPRIETARY

define RTL8723DS_BT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 644 -D $(@D)/8723D/rtl8723d_fw \
		$(TARGET_DIR)/lib/firmware/rtl_bt/rtl8723ds_fw.bin
	$(INSTALL) -m 644 -D $(@D)/8723D/rtl8723d_config \
		$(TARGET_DIR)/lib/firmware/rtl_bt/rtl8723ds_config.bin
endef

$(eval $(generic-package))
