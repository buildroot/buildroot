################################################################################
#
# widevine
#
################################################################################
WIDEVINE_VERSION = 315655c6ebf58a696b6dde78b14db7aad527e32f
WIDEVINE_SITE = git@github.com:Metrological/widevine.git
WIDEVINE_SITE_METHOD = git

WIDEVINE_INSTALL_STAGING = YES
WIDEVINE_DEPENDENCIES = host-gyp
WIDEVINE_LICENSE = BSD
WIDEVINE_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_WIDEVINE_SOC_RPI), y)
export WV_BOARD=rpi 
else
export WV_BOARD=dummy
endif #BR2_PACKAGE_WIDEVINE_SOC_RPI

export WV_CC=$(TARGET_CC)
export WV_CXX=$(TARGET_CXX)
export WV_AR=$(TARGET_AR)
export WV_HOST_CXX_FLAGS = $(HOST_CXXFLAGS)
export WV_HOST_CC = $(HOSTCC)
export WV_HOST_CXX = $(HOSTCXX)

define WIDEVINE_CONFIGURE_CMDS
      (cd $(@D);rm -rf out; rm -rf Makefile;\
       find . -name \*.mk -delete;\
       find . -name \*.pyc -delete;\
       ./build.py arm)
endef

define WIDEVINE_INSTALL_TARGET_CMDS
        cp $(@D)/out/arm/Debug/widevine_ce_cdm_unittest $(TARGET_DIR)/usr/bin
        cp $(@D)/out/arm/Debug/lib*/lib*.so $(TARGET_DIR)/usr/lib/
endef

define WIDEVINE_INSTALL_STAGING_CMDS
        cp $(@D)/out/arm/Debug/widevine_ce_cdm_unittest $(STAGING_DIR)/usr/bin
        cp $(@D)/out/arm/Debug/lib*/lib*.so $(STAGING_DIR)/usr/lib/
        cp $(@D)/cdm/include/*.h $(STAGING_DIR)/usr/include
        cp $(@D)/core/include/*.h $(STAGING_DIR)/usr/include
        mkdir -p $(STAGING_DIR)/usr/include/host
        cp $(@D)/cdm/src/host/rpi/*.h $(STAGING_DIR)/usr/include/host
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
