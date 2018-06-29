################################################################################
#
# PLAYGIGA
#
################################################################################

PLAYGIGA_VERSION = 897d0e9bbd1eef86554599c03a817d0d8c8c5c84
PLAYGIGA_SITE_METHOD = git
PLAYGIGA_SITE = https://github.com/Metrological/playgiga
PLAYGIGA_INSTALL_STAGING = YES
PLAYGIGA_DEPENDENCIES = host-cmake gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad libcurl opus

export BUILDROOT_HOST_PATH=$(HOST_DIR)

PLATFORM_DIR = wpe

define PLAYGIGA_INSTALL_IMAGE
    cp -a $(@D)/$(PLATFORM_DIR)/bin/pgclient $(TARGET_DIR)/usr/bin
endef

define PLAYGIGA_BUILD_CMDS
    $(BUILDROOT_HOST_PATH)/usr/bin/cmake $(@D)/$(PLATFORM_DIR)/CMakeLists.txt -DBUILDROOT_HOST_PATH=$(BUILDROOT_HOST_PATH)
    $(MAKE) -C $(@D)/$(PLATFORM_DIR) 
endef

define PLAYGIGA_INSTALL_TARGET_CMDS
    $(call PLAYGIGA_INSTALL_IMAGE)
endef

$(eval $(generic-package))
