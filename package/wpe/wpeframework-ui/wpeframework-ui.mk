################################################################################
#
# WPEFramework UI
#
################################################################################
WPEFRAMEWORK_UI_VERSION = R3.2
WPEFRAMEWORK_UI_SITE = $(call github,rdkcentral,ThunderUI,$(WPEFRAMEWORK_UI_VERSION))
WPEFRAMEWORK_UI_DEPENDENCIES = wpeframework wpeframework-plugins

WPEFRAMEWORK_UI_INSTALL_STAGING = NO
WPEFRAMEWORK_UI_INSTALL_TARGET = YES

WPEFRAMEWORK_UI_CONFIGURE_CMDS = true
WPEFRAMEWORK_UI_BUILD_CMDS = true

define WPEFRAMEWORK_UI_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/usr/share/WPEFramework/Controller/UI
	mkdir -p $(TARGET_DIR)/usr/share/WPEFramework/Controller/UI
	cp -r $(@D)/dist/* $(TARGET_DIR)/usr/share/WPEFramework/Controller/UI
endef

$(eval $(generic-package))
