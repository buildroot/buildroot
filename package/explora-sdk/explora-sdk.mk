################################################################################
#
# explora-sdk
#
################################################################################
EXPLORA_SDK_VERSION = 7aaab9f07fd8b0fc4e1a3a078e7d02983a8912fe
EXPLORA_SDK_SITE = git@github.com:Metrological/SDK_Explora.git
EXPLORA_SDK_SITE_METHOD = git
EXPLORA_SDK_INSTALL_STAGING = YES

define EXPLORA_SDK_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/libs/widevine/* $(STAGING_DIR)/usr/lib/
endef

$(eval $(generic-package))
