################################################################################
#
# open cdmi
#
################################################################################

OPENCDMI_VERSION = d62929ce501e5d509d99b2fe634ea52987a0c6ab
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
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
