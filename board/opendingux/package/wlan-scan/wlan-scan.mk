#############################################################
#
# wlan-scan
#
#############################################################

WLAN_SCAN_DEPENDENCIES = libnl

define WLAN_SCAN_BUILD_CMDS
	mkdir -p $(@D)
	$(TARGET_CC) $(TARGET_CFLAGS) -I $(STAGING_DIR)/usr/include/libnl3 \
		-o $(WLAN_SCAN_DIR)/wlan-scan -lnl-genl-3 -lnl-3 \
		board/opendingux/package/wlan-scan/wlan-scan.c
endef

define WLAN_SCAN_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(WLAN_SCAN_DIR)/wlan-scan $(TARGET_DIR)/usr/sbin/wlan-scan
endef

$(eval $(generic-package))
