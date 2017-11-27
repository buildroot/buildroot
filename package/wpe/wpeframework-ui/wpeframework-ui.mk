WPEFRAMEWORK_UI_VERSION = c092428260fe06f8b4dd3b8ec084ee760da5d4ee
WPEFRAMEWORK_UI_SITE_METHOD = git
WPEFRAMEWORK_UI_SITE = git@github.com:WebPlatformForEmbedded/WPEFrameworkUI.git
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
