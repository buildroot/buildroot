################################################################################
#
# COBALT
#
################################################################################

COBALT_VERSION = f83ae3a907628a0c697fc6196e529545c474e5dc
COBALT_SITE_METHOD = git
COBALT_SITE = git@github.com:Metrological/cobalt
COBALT_INSTALL_STAGING = YES
COBALT_DEPENDENCIES = gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad host-bison host-ninja wpeframework

export BUILDROOT_HOME=$(HOST_DIR)/usr
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

COBALT_BUILD_TYPE = qa

ifeq ($(BR2_PACKAGE_COBALT_IMAGE_AS_LIB), y)
export COBALT_EXECUTABLE_TYPE = shared_library
else
export COBALT_EXECUTABLE_TYPE = executable
endif

define COBALT_BUILD_CMDS
    $(@D)/src/cobalt/build/gyp_cobalt -C $(COBALT_BUILD_TYPE) $(COBALT_PLATFORM)
    $(BUILDROOT_HOME)/bin/ninja -C $(@D)/src/out/$(COBALT_PLATFORM)_$(COBALT_BUILD_TYPE) cobalt_deploy
endef

$(eval $(generic-package))
