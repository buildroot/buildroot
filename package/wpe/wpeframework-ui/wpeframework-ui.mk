################################################################################
#
# WPEFramework UI
#
################################################################################

WPEFRAMEWORK_UI_VERSION = b4d7365f59c47f7f6adeaddd3ccd33b4936c23bd
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
