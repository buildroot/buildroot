COBALT_VERSION = 06cbe09f396bfbcac0330c336180150352af2a94
COBALT_SITE = https://github.com/Metrological/cobalt
COBALT_SITE_METHOD = git
COBALT_INSTALL_STAGING = YES
COBALT_DEPENDENCIES = host-bison alsa-lib

export BUILDROOT_HOME=$(HOST_DIR)/usr
export PATH := $(HOST_DIR)/bin:$(HOST_DIR)/usr/bin:$(HOST_DIR)/usr/sbin:$(PATH)

PLATFORM_DIR = wpe-rpi
PLATFORM_QA_DIR = wpe-rpi_qa

ifeq ($(BR2_PACKAGE_COBALT_IMAGE_AS_LIB), y)
export COBALT_EXECUTABLE_TYPE = shared_library
else
export COBALT_EXECUTABLE_TYPE = executable
endif

ifeq ($(BR2_PACKAGE_COBALT_IMAGE_AS_LIB), y)
define COBALT_INSTALL_IMAGE
    cp -a $(@D)/src/out/$(PLATFORM_QA_DIR)/lib/libcobalt.so  $(TARGET_DIR)/usr/lib
endef
define COBALT_INSTALL_STAGING_IMAGE
    mkdir -p $(STAGING_DIR)/usr/include/starboard/wpe/shared
    mkdir -p $(STAGING_DIR)/usr/include/starboard/wpe/rpi

    cp $(@D)/src/starboard/*.h $(STAGING_DIR)/usr/include/starboard/
    cp $(@D)/src/starboard/wpe/rpi/*.h  $(STAGING_DIR)/usr/include/starboard/wpe/rpi
    cp $(@D)/src/starboard/wpe/shared/*.h  $(STAGING_DIR)/usr/include/starboard/wpe/shared

    cp -a $(@D)/src/out/$(PLATFORM_QA_DIR)/lib/libcobalt.so  $(STAGING_DIR)/usr/lib
endef
else
define COBALT_INSTALL_IMAGE
    cp -a $(@D)/src/out/$(PLATFORM_QA_DIR)/cobalt $(TARGET_DIR)/usr/bin
endef
endif

define COBALT_BUILD_CMDS
    $(@D)/src/cobalt/build/gyp_cobalt -C qa $(PLATFORM_DIR)
    $(BUILDROOT_HOME)/bin/ninja -C $(@D)/src/out/$(PLATFORM_QA_DIR) cobalt
endef

define COBALT_INSTALL_TARGET_CMDS
    cp -a $(@D)/src/out/$(PLATFORM_QA_DIR)/content $(TARGET_DIR)/usr/share
    rm -rf $(TARGET_DIR)/usr/bin/content
    ln -s /usr/share/content $(TARGET_DIR)/usr/bin/content
    $(call COBALT_INSTALL_IMAGE)
endef

define COBALT_INSTALL_STAGING_CMDS
    $(call COBALT_INSTALL_STAGING_IMAGE)
endef

$(eval $(generic-package))
