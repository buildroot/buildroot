################################################################################
#
# widevine
#
################################################################################

WIDEVINE_VERSION = 5a2581a1464c610a69351f765d6b1de29d64903d
WIDEVINE_SITE_METHOD = git
WIDEVINE_SITE = https://github.com/Metrological/widevine.git

WIDEVINE_INSTALL_STAGING = YES
WIDEVINE_DEPENDENCIES =
WIDEVINE_LICENSE = BSD
WIDEVINE_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_WIDEVINE_SOC_RPI), y)
export WV_BOARD=rpi 
endif #BR2_PACKAGE_WIDEVINE_SOC_RPI

export WV_CC=$(TARGET_CC)
export WV_CXX=$(TARGET_CXX)
export WV_AR=$(TARGET_AR)
       # CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AR="$(TARGET_AR)" \

define WIDEVINE_CONFIGURE_CMDS
      (cd $(@D);rm -rf out; rm -rf Makefile;\
       find . -name \*.mk -delete;\
       find . -name \*.pyc -delete;\
       ./build.py arm)
endef

define WIDEVINE_BUILD_CMDS
        export WIDEVINE_TARGET_DIR="$(TARGET_DIR)";\
        export WIDEVINE_STAGING_DIR="$(STAGING_DIR)";\
        make CROSS_COMPILE="$(TARGET_CROSS)" \
        CXXFLAGS="$(TARGET_CXXFLAGS)" \
        LDFLAGS="$(TARGET_LDFLAGS)  -L$(STAGING_DIR)/usr/lib" -C $(@D) -f Makefile
endef

define WIDEVINE_INSTALL_TARGET_CMDS
        cp $(@D)/out/arm/Debug/widevine_ce_cdm_unittest $(TARGET_DIR)/usr/bin
        cp $(@D)/out/arm/Debug/lib.target/lib*.so $(TARGET_DIR)/usr/lib/
endef

define WIDEVINE_INSTALL_STAGING_CMDS
        cp $(@D)/out/arm/Debug/widevine_ce_cdm_unittest $(STAGING_DIR)/usr/bin
        cp $(@D)/out/arm/Debug/lib.target/lib*.so $(STAGING_DIR)/usr/lib/
        cp $(@D)/cdm/include/*.h $(STAGING_DIR)/usr/include
        cp $(@D)/core/include/*.h $(STAGING_DIR)/usr/include
        mkdir -p $(STAGING_DIR)/usr/include/host
        cp $(@D)/cdm/src/host/rpi/*.h $(STAGING_DIR)/usr/include/host
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
