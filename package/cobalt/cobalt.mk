################################################################################
#
# COBALT
#
################################################################################

COBALT_VERSION = 1ce72e8929579921868c9d87a0ba4128cc88d9e9
COBALT_SITE_METHOD = git
COBALT_SITE = git@github.com:Metrological/cobalt
COBALT_INSTALL_STAGING = YES
COBALT_DEPENDENCIES = gst1-plugins-good gst1-plugins-bad host-bison host-ninja wpeframework-clientlibraries

export COBALT_STAGING_DIR=$(STAGING_DIR)
export COBALT_TOOLCHAIN_PREFIX=$(TARGET_CROSS)
export COBALT_INSTALL_DIR=$(TARGET_DIR)

export PATH := $(HOST_DIR)/bin:$(HOST_DIR)/usr/bin:$(HOST_DIR)/usr/sbin:$(PATH)

ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
# TODO: we might also have mips here at some point.
COBALT_PLATFORM = wpe-brcm-arm
COBALT_DEPENDENCIES += gst1-bcm
else
COBALT_PLATFORM = wpe-rpi
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_CDM),y)
export COBALT_HAS_OCDM=1
else
export COBALT_HAS_OCDM=0
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROVISIONPROXY),y)
export COBALT_HAS_PROVISION=1
else
export COBALT_HAS_PROVISION=0
endif

ifeq ($(BR2_PACKAGE_WESTON),y)
export COBALT_HAS_WAYLANDSINK=1
COBALT_DEPENDENCIES += weston
else
export COBALT_HAS_WAYLANDSINK=0
endif

ifeq ($(BR2_PACKAGE_COBALT_BUILD_TYPE_QA),y)
	COBALT_BUILD_TYPE = qa
	COBALT_DEPENDENCIES += host-nodejs
else ifeq ($(BR2_PACKAGE_COBALT_BUILD_TYPE_GOLD),y)
	COBALT_BUILD_TYPE = gold
endif

ifeq ($(BR2_PACKAGE_COBALT_IMAGE_AS_LIB), y)
export COBALT_EXECUTABLE_TYPE = shared_library
else
export COBALT_EXECUTABLE_TYPE = executable
endif

export COBALT_DATA_PATH = "$(subst ",,$(BR2_PACKAGE_WPEFRAMEWORK_DATA_PATH)")/Cobalt"
COBALT_DATA_INSTALL_PATH = $(TARGET_DIR)/$(COBALT_DATA_PATH)

define COBALT_BUILD_CMDS
    $(@D)/src/cobalt/build/gyp_cobalt -C $(COBALT_BUILD_TYPE) $(COBALT_PLATFORM)
    $(HOST_DIR)/usr/bin/ninja -C $(@D)/src/out/$(COBALT_PLATFORM)_$(COBALT_BUILD_TYPE) cobalt_deploy
endef

define COBALT_INSTALL_TARGET_CMDS
    cp -a $(@D)/src/out/$(COBALT_PLATFORM)_$(COBALT_BUILD_TYPE)/content/data/* $(COBALT_DATA_INSTALL_PATH)
endef


$(eval $(generic-package))
