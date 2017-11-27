################################################################################
#
# open cdmi
#
################################################################################

OPENCDMI_VERSION = fe53d4303452a24846f88cb0a27859702e91d697
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

ifeq ($(BR2_PACKAGE_PLAYREADY), y)
export CDMI_PR=1;
OPENCDMI_DEPENDENCIES += playready
endif #BR2_PACKAGE_PLAYREADY

ifeq ($(BR2_PACKAGE_OPENCDMI_SERVICE), y)
OPENCDMI_TARGET=all
OPENCDMI_SERVICE=$(@D)/cdmiservice
else
OPENCDMI_TARGET=ocdmilib
endif

define OPENCDMI_CONFIGURE_CMDS
    cd $(@D);find -iname "*.o" | xargs rm -rf; \
    find -iname "*.a" | xargs rm -rf
endef

define OPENCDMI_BUILD_CMDS
    export OPENCDMI_TARGET_DIR="$(TARGET_DIR)";\
    export OPENCDMI_STAGING_DIR="$(STAGING_DIR)";\
    export CDMI_MAKE_CONFIG="config_cdmi.mk";\
    make CROSS_COMPILE="$(TARGET_CROSS)" \
    CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" AR="$(TARGET_AR)" \
    CXXFLAGS="$(TARGET_CXXFLAGS) -fPIC" \
    LDFLAGS="$(TARGET_LDFLAGS)  -L$(STAGING_DIR)/usr/lib  -pthread" -C $(@D) $(OPENCDMI_TARGET)
endef

ifeq ($(BR2_PACKAGE_OPENCDMI_SERVICE), y)
define OPENCDMI_INSTALL_TARGET_CMDS
    cp $(@D)/libocdmi.so $(TARGET_DIR)/usr/lib
    cp $(@D)/cdmiservice $(TARGET_DIR)/usr/bin
endef
define OPENCDMI_INSTALL_INIT_SYSV
    $(INSTALL) -D -m 0755 package/opencdmi/S85opencdmi $(TARGET_DIR)/etc/init.d/S85opencdmi
endef
else
define OPENCDMI_INSTALL_TARGET_CMDS
    cp $(@D)/libocdmi.so $(TARGET_DIR)/usr/lib
endef
endif
define OPENCDMI_INSTALL_STAGING_CMDS
    cp $(@D)/libocdmi.so $(STAGING_DIR)/usr/lib
    mkdir -p $(STAGING_DIR)/usr/include/opencdmi
    cp -r $(@D)/rpc/gen/opencdm_xdr_svc.h $(STAGING_DIR)/usr/include/opencdmi
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
