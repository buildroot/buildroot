################################################################################
#
# uma-sdk
#
################################################################################
UMA_SDK_VERSION = master
UMA_SDK_SITE = git@github.com:Metrological/OperatorDeliveries.git
UMA_SDK_SITE_METHOD = git
UMA_SDK_INSTALL_STAGING = YES
UMA_SDK_INSTALL_TARGET = YES

define UMA_SDK_INSTALL_STAGING_CMDS
	cp -Rpf $(@D)/nos/player/usr/include/*.h $(STAGING_DIR)/usr/include/
	$(INSTALL) -m 0755 -D $(@D)/nos/player/usr/lib/libplayer.so $(STAGING_DIR)/usr/lib/
endef

define UMA_SDK_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/nos/player/usr/lib/libplayer.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
