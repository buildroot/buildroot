################################################################################
#
# explora-sdk
#
################################################################################
EXPLORA_SDK_VERSION = 11f96e3cccb4aaca90feb1bfcb67210ede723a14
EXPLORA_SDK_SITE = git@github.com:Metrological/SDK_Explora.git
EXPLORA_SDK_SITE_METHOD = git
EXPLORA_SDK_INSTALL_STAGING = YES

define EXPLORA_SDK_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/lib
	$(INSTALL) -D -m 0644 $(@D)/libs/widevine/* $(STAGING_DIR)/usr/lib/

	$(INSTALL) -d $(STAGING_DIR)/usr/include/widevine
	$(INSTALL) -D -m 0644 $(@D)/includes/widevine/* $(STAGING_DIR)/usr/include/widevine
endef

$(eval $(generic-package))
