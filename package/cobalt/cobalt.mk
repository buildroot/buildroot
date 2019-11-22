################################################################################
#
# COBALT
#
################################################################################

COBALT_VERSION = 9d12f95b55d10cafda3f8aac0e193290a234f6a7
COBALT_SITE_METHOD = git
COBALT_SITE = git@github.com:Metrological/cobalt
COBALT_INSTALL_STAGING = YES
COBALT_DEPENDENCIES = gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad host-bison host-ninja wpeframework

export BUILDROOT_HOME=$(HOST_DIR)/usr
export PATH := $(HOST_DIR)/bin:$(HOST_DIR)/usr/bin:$(HOST_DIR)/usr/sbin:$(PATH)

ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
# TODO: we might also have mips here at some point.
COBALT_PLATFORM = wpe-brcm-arm
COBALT_PLATFORM_DIR = brcm/arm
COBALT_DEPENDENCIES += gst1-bcm
else
COBALT_PLATFORM = wpe-rpi
COBALT_PLATFORM_DIR = rpi
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDM),y)
export COBALT_HAS_OCDM=1
else
export COBALT_HAS_OCDM=0
endif

COBALT_BUILD_TYPE = qa

ifeq ($(BR2_PACKAGE_COBALT_IMAGE_AS_LIB), y)
export COBALT_EXECUTABLE_TYPE = shared_library
else
export COBALT_EXECUTABLE_TYPE = executable
endif

ifeq ($(BR2_PACKAGE_COBALT_IMAGE_AS_LIB), y)
define COBALT_INSTALL_IMAGE
    cp -a $(@D)/src/out/$(COBALT_PLATFORM)_$(COBALT_BUILD_TYPE)/lib/libcobalt.so  $(TARGET_DIR)/usr/lib
endef
define COBALT_INSTALL_STAGING_IMAGE
    mkdir -p $(STAGING_DIR)/usr/include/starboard/
    mkdir -p $(STAGING_DIR)/usr/include/third_party/starboard/wpe/shared
    mkdir -p $(STAGING_DIR)/usr/include/third_party/starboard/wpe/$(COBALT_PLATFORM_DIR)

    cp $(@D)/src/starboard/*.h $(STAGING_DIR)/usr/include/starboard/
    cp $(@D)/src/third_party/starboard/wpe/$(COBALT_PLATFORM_DIR)/*.h  $(STAGING_DIR)/usr/include/third_party/starboard/wpe/$(COBALT_PLATFORM_DIR)
    cp $(@D)/src/third_party/starboard/wpe/shared/*.h  $(STAGING_DIR)/usr/include/third_party/starboard/wpe/shared

    cp -a $(@D)/src/out/$(COBALT_PLATFORM)_$(COBALT_BUILD_TYPE)/lib/libcobalt.so  $(STAGING_DIR)/usr/lib
endef
else
define COBALT_INSTALL_IMAGE
    cp -a $(@D)/src/out/$(COBALT_PLATFORM)_$(COBALT_BUILD_TYPE)/cobalt $(TARGET_DIR)/usr/bin
endef
endif

define COBALT_BUILD_CMDS
    $(@D)/src/cobalt/build/gyp_cobalt -C $(COBALT_BUILD_TYPE) $(COBALT_PLATFORM)
    $(BUILDROOT_HOME)/bin/ninja -C $(@D)/src/out/$(COBALT_PLATFORM)_$(COBALT_BUILD_TYPE) cobalt
endef

define COBALT_INSTALL_TARGET_CMDS
    cp -a $(@D)/src/out/$(COBALT_PLATFORM)_$(COBALT_BUILD_TYPE)/content $(TARGET_DIR)/usr/share
    rm -rf $(TARGET_DIR)/usr/bin/content
    ln -s /usr/share/content $(TARGET_DIR)/usr/bin/content
    $(call COBALT_INSTALL_IMAGE)
endef

define COBALT_INSTALL_STAGING_CMDS
    $(call COBALT_INSTALL_STAGING_IMAGE)
endef

$(eval $(generic-package))
