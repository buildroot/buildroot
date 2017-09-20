################################################################################
#
# vip-sdk
#
################################################################################

define VIP_SDK_INSTALL_TARGET_CMDS
	$(INSTALL) -m 644 -D $(STAGING_DIR)/usr/lib/libnxclient.so $(TARGET_DIR)/usr/lib
endef
	
$(eval $(virtual-package))
