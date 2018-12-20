################################################################################
#
# explora-sdk
#
################################################################################
EXPLORA_SDK_VERSION = caf26482fd97afa422ea351903701202fed28050
EXPLORA_SDK_SITE = git@github.com:Metrological/SDK_Explora.git
EXPLORA_SDK_SITE_METHOD = git
EXPLORA_SDK_INSTALL_STAGING = NO
EXPLORA_SDK_INSTALL_TARGET = YES

define EXPLORA_SDK_INSTALL_TARGET_CMDS
	mkdir -p  $(TARGET_DIR)$(BR2_PACKAGE_BCM_REFSW_SAGE_PATH)
	$(INSTALL) -D -m 0644 $(@D)/firmware/sage/release/* $(TARGET_DIR)/$(BR2_PACKAGE_BCM_REFSW_SAGE_PATH)/
	$(INSTALL) -D -m 0644 $(@D)/firmware/drm/* $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
