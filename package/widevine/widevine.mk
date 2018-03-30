################################################################################
#
# widevine
#
################################################################################
WIDEVINE_VERSION = 13e071face6c9292d223e3408a099153cee14f4b
WIDEVINE_SITE = git@github.com:Metrological/widevine.git
WIDEVINE_SITE_METHOD = git

WIDEVINE_INSTALL_STAGING = YES
WIDEVINE_DEPENDENCIES = host-gyp
WIDEVINE_LICENSE = BSD
WIDEVINE_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_WIDEVINE_SOC_RPI), y)
export WV_BOARD = rpi
WIDEVINE_ARCHITECTURE = arm
else ifeq ($(BR2_PACKAGE_WIDEVINE_SOC_WPE), y)
export WV_BOARD = wpe
WIDEVINE_ARCHITECTURE = wpe
WIDEVINE_DEPENDENCIES += wpeframework
else
export WV_BOARD=dummy
endif #BR2_PACKAGE_WIDEVINE_SOC_RPI

export WV_CC=$(TARGET_CC)
export WV_CXX=$(TARGET_CXX)
export WV_AR=$(TARGET_AR)
export WV_HOST_CXX_FLAGS = $(HOST_CXXFLAGS)
export WV_HOST_CC = $(HOSTCC)
export WV_HOST_CXX = $(HOSTCXX)
export WV_STAGING = $(STAGING_DIR)
export WV_STAGING_NATIVE = $(STAGING_DIR)
export WV_PROTOBUF_CONFIG = source

define WIDEVINE_CONFIGURE_CMDS
      (cd $(@D);rm -rf out; rm -rf Makefile;\
       find . -name \*.mk -delete;\
       find . -name \*.pyc -delete;\
       ./build.py $(WIDEVINE_ARCHITECTURE) )
endef

define WIDEVINE_INSTALL_TARGET_CMDS
        cp $(@D)/out/$(WIDEVINE_ARCHITECTURE)/Debug/widevine_ce_cdm_unittest $(TARGET_DIR)/usr/bin
        cp $(@D)/out/$(WIDEVINE_ARCHITECTURE)/Debug/lib*/lib*.so $(TARGET_DIR)/usr/lib/
endef

define WIDEVINE_INSTALL_STAGING_CMDS
        cp $(@D)/out/$(WIDEVINE_ARCHITECTURE)/Debug/lib*/lib*.so $(STAGING_DIR)/usr/lib/
        cp $(@D)/cdm/include/*.h $(STAGING_DIR)/usr/include
        cp $(@D)/core/include/*.h $(STAGING_DIR)/usr/include
        # mkdir -p $(STAGING_DIR)/usr/include/host
        # cp $(@D)/cdm/src/host/$(WIDEVINE_ARCHITECTURE)/*.h $(STAGING_DIR)/usr/include/host
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
