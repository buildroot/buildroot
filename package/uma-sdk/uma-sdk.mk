################################################################################
#
# uma-sdk
#
################################################################################
UMA_SDK_VERSION = 787f93d172ae7d01dbc5201b1014c20b0133b036
UMA_SDK_SITE = git@github.com:Metrological/SDK_UMA.git
UMA_SDK_SITE_METHOD = git
UMA_SDK_INSTALL_STAGING = YES
UMA_SDK_INSTALL_TARGET = YES

define UMA_SDK_INSTALL_STAGING_CMDS
	cp -Rpf $(@D)/usr/include/* $(STAGING_DIR)/usr/include/
	ln -sf $(STAGING_DIR)/usr/include/NOSPlayer/Player.h $(STAGING_DIR)/usr/include/Player.h
	cp -Rpf $(@D)/usr/lib/Player/* $(STAGING_DIR)/usr/lib/
	cp -Rpf $(@D)/usr/lib/Nagra/* $(STAGING_DIR)/usr/lib/
endef

define UMA_SDK_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/usr/lib/Player/* $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
