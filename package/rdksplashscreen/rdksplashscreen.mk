################################################################################
#
# WPEFramework UI
#
################################################################################

RDKSPLASHSCREEN_VERSION = 720f13e9ff59d8470bb869d927c83e199768c36d
RDKSPLASHSCREEN_SITE = $(call github,WebPlatformForEmbedded,RDKSplashScreen,$(RDKSPLASHSCREEN_VERSION))
RDKSPLASHSCREEN_DEPENDENCIES = wpeframework wpeframework-plugins

RDKSPLASHSCREEN_INSTALL_STAGING = NO
RDKSPLASHSCREEN_INSTALL_TARGET = YES

RDKSPLASHSCREEN_CONFIGURE_CMDS = true
RDKSPLASHSCREEN_BUILD_CMDS = true

define RDKSPLASHSCREEN_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/www/*
	cp -r $(@D)/* $(TARGET_DIR)/www/
endef

$(eval $(generic-package))
