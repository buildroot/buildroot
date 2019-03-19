################################################################################
#
# rtcore
#
################################################################################
PXCORE_TOOLS_VERSION = cbb16e1c6a4166175aaf178d7e9c15b617d35d7a
PXCORE_TOOLS_SITE_METHOD = git
PXCORE_TOOLS_SITE = git://github.com/pxscene/pxCore
PXCORE_TOOLS_INSTALL_STAGING = YES

PXCORE_TOOLS_CONF_OPTS += \
    -DBUILD_PXCORE_LIBS=OFF \
    -DBUILD_PXSCENE=OFF

ifeq ($(BR2_PACKAGE_PXCORE_DUKLUV),y)
PXCORE_TOOLS_CONF_OPTS += \
    -DSUPPORT_DUKTAPE=ON -DBUILD_DUKTAPE=ON

PXCORE_TOOLS_DUKLUV_PATH = examples/pxScene2d/external/dukluv
endif

ifeq ($(BR2_PACKAGE_PXCORE_RTCORE),y)
PXCORE_TOOLS_CONF_OPTS += \
    -DBUILD_RTCORE_LIBS=ON \
    -DBUILD_RTCORE_STATIC_LIB=OFF
endif

ifeq ($(BR2_PACKAGE_PXCORE_RTCORE),y)
define RTCORE_INSTALL_STAGING_CMDS
    mkdir -p $(STAGING_DIR)/usr/include/unix
    cp -Rpf $(@D)/src/*.h $(STAGING_DIR)/usr/include/
    cp -Rpf $(@D)/src/unix/*.h $(STAGING_DIR)/usr/include/unix
    $(INSTALL) -m 755 $(@D)/build/glut/librtCore.so $(STAGING_DIR)/usr/lib/
endef
endif

ifeq ($(BR2_PACKAGE_PXCORE_DUKLUV),y)
define DUKLUV_INSTALL_STAGING_CMDS
    mkdir -p $(STAGING_DIR)/usr/include/duv
    cp -Rpf $(@D)/$(PXCORE_TOOLS_DUKLUV_PATH)/src/refs.h $(@D)/$(PXCORE_TOOLS_DUKLUV_PATH)/src/duv.h \
            $(@D)/$(PXCORE_TOOLS_DUKLUV_PATH)/lib/duktape/src-separate/duk_config.h $(@D)/$(PXCORE_TOOLS_DUKLUV_PATH)/lib/duktape/src-separate/duktape.h \
            $(STAGING_DIR)/usr/include/duv
    cp -Rpf $(@D)/$(PXCORE_TOOLS_DUKLUV_PATH)/build/lib*.a $(STAGING_DIR)/usr/lib
endef
endif

define PXCORE_TOOLS_INSTALL_STAGING_CMDS
    make -C $(@D) preinstall
    $(DUKLUV_INSTALL_STAGING_CMDS)
    $(RTCORE_INSTALL_STAGING_CMDS)
endef

define PXCORE_TOOLS_INSTALL_TARGET_CMDS
    make -C $(@D) preinstall
    $(INSTALL) -m 755 $(@D)/build/glut/librtCore.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(cmake-package))
