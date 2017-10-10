WPEFRAMEWORK_UI_VERSION = 044611d850073c4154873a796d066c4e713fd5ed
WPEFRAMEWORK_UI_SITE_METHOD = git
WPEFRAMEWORK_UI_SITE = git@github.com:WebPlatformForEmbedded/WPEFrameworkUI.git
WPEFRAMEWORK_UI_DEPENDENCIES = wpeframework wpeframework-plugins

WPEFRAMEWORK_UI_INSTALL_STAGING = NO
WPEFRAMEWORK_UI_INSTALL_TARGET = YES

WPEFRAMEWORK_UI_CONFIGURE_CMDS = true
WPEFRAMEWORK_UI_BUILD_CMDS = true

define WPEFRAMEWORK_UI_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/WPEFramework/Controller/UI
	rm -r $(TARGET_DIR)/usr/share/WPEFramework/Controller/UI/*
	cp -r $(@D)/build/* $(TARGET_DIR)/usr/share/WPEFramework/Controller/UI 
endef

$(eval $(generic-package))
