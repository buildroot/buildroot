################################################################################
#
# COBALT
#
################################################################################

COBALT_VERSION = 8c7a8bd5b66160eb32bcc59d535665ae02961159
COBALT_SITE_METHOD = git
COBALT_SITE = git@github.com:Metrological/cobalt
COBALT_INSTALL_STAGING = YES
COBALT_DEPENDENCIES = alsa-lib gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad host-bison host-ninja

export RASPI_HOME=$(HOST_DIR)/usr
export PATH := $(HOST_DIR)/bin:$(HOST_DIR)/usr/bin:$(HOST_DIR)/usr/sbin:$(PATH)

PLATFORMDIR = raspi-2
PLATFORM_QA_DIR = raspi-2_qa

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
    mkdir -p $(STAGING_DIR)/usr/include/starboard/raspi/shared
    mkdir -p $(STAGING_DIR)/usr/include/starboard/raspi/2

    cp $(@D)/src/starboard/*.h $(STAGING_DIR)/usr/include/starboard/
    cp $(@D)/src/starboard/raspi/2/*.h  $(STAGING_DIR)/usr/include/starboard/raspi/2
    cp $(@D)/src/starboard/raspi/shared/*.h  $(STAGING_DIR)/usr/include/starboard/raspi/shared

    cp -a $(@D)/src/out/$(PLATFORM_QA_DIR)/lib/libcobalt.so  $(STAGING_DIR)/usr/lib
endef
else
define COBALT_INSTALL_IMAGE
    cp -a $(@D)/src/out/$(PLATFORM_QA_DIR)/cobalt $(TARGET_DIR)/usr/bin
endef
endif

define COBALT_BUILD_CMDS
    $(@D)/src/cobalt/build/gyp_cobalt -C qa $(PLATFORMDIR)
    $(RASPI_HOME)/bin/ninja -C $(@D)/src/out/$(PLATFORM_QA_DIR) cobalt
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
