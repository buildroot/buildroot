################################################################################
#
# WPEFramework UI
#
################################################################################

WPEFRAMEWORK_UI_VERSION = ef53dcfa8d9dd4bf0894caf1367ab6fe2c2a48ee 
WPEFRAMEWORK_UI_SITE = $(call github,WebPlatformForEmbedded,WPEFrameworkUI,$(WPEFRAMEWORK_UI_VERSION))
WPEFRAMEWORK_UI_DEPENDENCIES = wpeframework wpeframework-plugins

WPEFRAMEWORK_UI_INSTALL_STAGING = NO
WPEFRAMEWORK_UI_INSTALL_TARGET = YES

WPEFRAMEWORK_UI_CONFIGURE_CMDS = true
WPEFRAMEWORK_UI_BUILD_CMDS = true

define WPEFRAMEWORK_UI_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/usr/share/WPEFramework/Controller/UI
	mkdir -p $(TARGET_DIR)/usr/share/WPEFramework/Controller/UI
	cp -r $(@D)/build/* $(TARGET_DIR)/usr/share/WPEFramework/Controller/UI
endef

$(eval $(generic-package))
