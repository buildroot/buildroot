################################################################################
#
# wdmp-c
#
################################################################################

WDMP_C_VERSION =e959418e373cceae663d8913cfb60a436d6b2140
WDMP_C_SITE_METHOD = git
WDMP_C_SITE = https://github.com/xmidt-org/wdmp-c.git
WDMP_C_INSTALL_STAGING = YES

WDMP_C_CONF_OPTS += \
    -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(WDMP_C_INCLUDE_DIRS)" \
    -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(WDMP_C_INCLUDE_DIRS)" \
    -DBUILD_TESTING=OFF \
    -DBUILD_BR=ON


WDMP_C_INCLUDE_DIRS = \
    -I$(STAGING_DIR)/usr/include \
    -I$(STAGING_DIR)/usr/include/cjson


#define WDMP_C_INSTALL_TARGET_CMDS
#    cp -a $(@D)/src/libwdmp-c.so* $(TARGET_DIR)/usr/lib
#endef

#define WDMP_C_INSTALL_STAGING_CMDS
#    cp -a $(@D)/src/libwdmp-c.so* $(STAGING_DIR)/usr/lib
#endef
$(eval $(cmake-package))
