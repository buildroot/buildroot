################################################################################
#
# AVN_CLIENT
#
################################################################################

AVN_CLIENT_VERSION = a340713b4a5475266fd5d1504f43edb27871b3e8
AVN_CLIENT_SITE_METHOD = git
AVN_CLIENT_SITE = git@github.com:Metrological/avn-nanoclient.git
AVN_CLIENT_INSTALL_STAGING = YES
AVN_CLIENT_DEPENDENCIES = gstreamer1 gst1-plugins-base \
	gst1-plugins-good gst1-plugins-bad 

export SYSROOTPATH=$(STAGING_DIR)

AVN_CLIENT_MAKE_OPTS = ARCH=$(BR2_ARCH) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)"

ifeq ($(BR2_PACKAGE_AVN_CLIENT_APP),y)
export AVNCLIENT_APP=true
define AVN_CLIENT_INSTALL_IMAGE
	cp -a $(@D)/output/linux/release/bin/mclient $(TARGET_DIR)/usr/bin
endef
else
export AVNCLIENT_APP=false
define AVN_CLIENT_INSTALL_IMAGE
	cp -a $(@D)/output/linux/release/lib/libcloudtv_mclient.so $(TARGET_DIR)/usr/lib
endef
define AVN_CLIENT_INSTALL_STAGING_IMAGE
	cp -a $(@D)/output/linux/release/lib/libcloudtv_mclient.so $(STAGING_DIR)/usr/lib
endef
endif

define AVN_CLIENT_BUILD_CMDS
    	$(MAKE) -C $(@D) clean
    	$(MAKE) -C $(@D) $(AVN_CLIENT_MAKE_OPTS) 
endef

define AVN_CLIENT_INSTALL_TARGET_CMDS
    	$(call AVN_CLIENT_INSTALL_IMAGE)
endef

define AVN_CLIENT_INSTALL_STAGING_CMDS
        $(call AVN_CLIENT_INSTALL_STAGING_IMAGE)
endef
$(eval $(generic-package))
