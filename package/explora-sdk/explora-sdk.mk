################################################################################
#
# explora-sdk
#
################################################################################
EXPLORA_SDK_VERSION = 507604e7d93a52c986d8e6d314b4ddc7aad6912d
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
