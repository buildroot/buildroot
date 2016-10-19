################################################################################
#
# open cdmi
#
################################################################################

OPENCDMI_VERSION = a5748b2869b7af3b6c147e1465fce117bed0656f
OPENCDMI_SITE_METHOD = git
OPENCDMI_SITE = git@github.com:Metrological/open-content-decryption-module-cdmi.git

OPENCDMI_INSTALL_STAGING = YES
OPENCDMI_DEPENDENCIES = rpcbind opencdm
OPENCDMI_LICENSE = Apache-2.0
OPENCDMI_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_WIDEVINE), y)
export CDMI_WV=1;
OPENCDMI_DEPENDENCIES += widevine
endif #BR2_PACKAGE_WIDEVINE

define OPENCDMI_BUILD_CMDS
        export OPENCDMI_TARGET_DIR="$(TARGET_DIR)";\
        export OPENCDMI_STAGING_DIR="$(STAGING_DIR)";\
        export CDMI_MAKE_CONFIG="config_cdmi.mk";\
        make CROSS_COMPILE="$(TARGET_CROSS)" \
        CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AR="$(TARGET_AR)" \
        CXXFLAGS="$(TARGET_CXXFLAGS) -fPIC" \
        LDFLAGS="$(TARGET_LDFLAGS)  -L$(STAGING_DIR)/usr/lib  -pthread" -C $(@D)

endef
define OPENCDMI_INSTALL_TARGET_CMDS
        cp $(@D)/cdmiservice $(TARGET_DIR)/usr/bin
        cp $(@D)/libocdmi.so $(TARGET_DIR)/usr/lib
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
