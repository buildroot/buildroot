################################################################################
#
# open cdmi
#
################################################################################

OPENCDMI_VERSION = a0940e12e8cbc2a0954ab6d9957c29e158439bd7
OPENCDMI_SITE_METHOD = git
OPENCDMI_SITE = https://github.com/fraunhoferfokus/open-content-decryption-module-cdmi.git

OPENCDMI_INSTALL_STAGING = YES
OPENCDMI_DEPENDENCIES = rpcbind opencdm
OPENCDMI_LICENSE = Apache-2.0
OPENCDMI_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_WIDEVINE), y)
export CDMI_WV=1;
endif #BR2_PACKAGE_WIDEVINE

define OPENCDMI_BUILD_CMDS
        export OPENCDMI_TARGET_DIR="$(TARGET_DIR)";\
        export OPENCDMI_STAGING_DIR="$(STAGING_DIR)";\
        export CDMI_MAKE_CONFIG="config_cdmi.mk";\
        $(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" \
        CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AR="$(TARGET_AR)" \
        CXXFLAGS="$(TARGET_CXXFLAGS)" \
        LDFLAGS="$(TARGET_LDFLAGS)  -L$(STAGING_DIR)/usr/lib  -pthread" -C $(@D)

endef
define OPENCDMI_INSTALL_TARGET_CMDS
        cp $(@D)/cdmiservice $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
