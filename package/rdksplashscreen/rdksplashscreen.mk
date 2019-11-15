################################################################################
#
# WPEFramework UI
#
################################################################################

RDKSPLASHSCREEN_VERSION = 47a633ede5cea5f6f4efd3370640de9a68542fb2
RDKSPLASHSCREEN_SITE = $(call github,WebPlatformForEmbedded,RDKSplashScreen,$(RDKSPLASHSCREEN_VERSION))
RDKSPLASHSCREEN_DEPENDENCIES = wpeframework wpeframework-plugins

RDKSPLASHSCREEN_INSTALL_STAGING = NO
RDKSPLASHSCREEN_INSTALL_TARGET = YES

RDKSPLASHSCREEN_CONFIGURE_CMDS = true
RDKSPLASHSCREEN_BUILD_CMDS = true

define RDKSPLASHSCREEN_INSTALL_TARGET_CMDS
	if [ -d $(TARGET_DIR)/www ] ; then \
		rm -rf $(TARGET_DIR)/www/*;\
	else                               \
		mkdir -p $(TARGET_DIR)/www;\
	fi
	cp -r $(@D)/* $(TARGET_DIR)/www/
endef

define RDKSPLASHSCREEN_WRITE_URL
        cp -r $(@D)/static/config/config.url.in $(TARGET_DIR)/www/config.json
        sed -i -e s,%url%,$(BR2_PACKAGE_RDKSPLASHSCREEN_URL),g $(TARGET_DIR)/www/config.json
endef

define RDKSPLASHSCREEN_WRITE_OPERATOR
	cp -r $(@D)/static/config/config.operator.in $(TARGET_DIR)/www/config.json
	sed -i -e s,%operator%,$(BR2_PACKAGE_RDKSPLASHSCREEN_OPERATOR),g $(TARGET_DIR)/www/config.json
endef

ifneq ($(BR2_PACKAGE_RDKSPLASHSCREEN_URL),"")
RDKSPLASHSCREEN_POST_INSTALL_TARGET_HOOKS += RDKSPLASHSCREEN_WRITE_URL
endif

ifneq ($(BR2_PACKAGE_RDKSPLASHSCREEN_OPERATOR),"")
RDKSPLASHSCREEN_POST_INSTALL_TARGET_HOOKS += RDKSPLASHSCREEN_WRITE_OPERATOR
endif

$(eval $(generic-package))
