################################################################################
#
# widevine
#
################################################################################

WIDEVINE_VERSION = 8d115c5c82464ba2c9ea0bb58e88f7f2db19a8b6
WIDEVINE_SITE_METHOD = git
WIDEVINE_SITE = https://github.com/Metrological/widevine.git

WIDEVINE_INSTALL_STAGING = YES
WIDEVINE_DEPENDENCIES =
WIDEVINE_LICENSE = BSD
WIDEVINE_LICENSE_FILES = LICENSE

define WIDEVINE_CONFIGURE_CMDS
      (cd $(@D);rm -rf out; rm -rf Makefile;./build.py arm)
endef

define WIDEVINE_BUILD_CMDS
        export WIDEVINE_TARGET_DIR="$(TARGET_DIR)";\
        export WIDEVINE_STAGING_DIR="$(STAGING_DIR)";\
        make CROSS_COMPILE="$(TARGET_CROSS)" \
        CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AR="$(TARGET_AR)" \
        CXXFLAGS="$(TARGET_CXXFLAGS)" \
        LDFLAGS="$(TARGET_LDFLAGS)  -L$(STAGING_DIR)/usr/lib" -C $(@D) -f Makefile
endef

define WIDEVINE_INSTALL_TARGET_CMDS
        cp $(@D)/out/arm/Debug/widevine_ce_cdm_unittest $(TARGET_DIR)/usr/bin
        cp $(@D)/out/arm/Debug/lib.target/lib*.so $(TARGET_DIR)/usr/lib/
endef

define WIDEVINE_INSTALL_STAGING_CMDS
        cp $(@D)/out/arm/Debug/lib.target/lib*.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
