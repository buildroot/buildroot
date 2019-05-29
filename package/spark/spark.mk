################################################################################
#
# spark
#
################################################################################
SPARK_VERSION = 746382b7139bb7de4ebe357d766a4fbac243cab9
SPARK_SITE_METHOD = git
SPARK_SITE = git://github.com/pxscene/pxCore
SPARK_INSTALL_STAGING = YES

SPARK_DEPENDENCIES = openssl freetype util-linux libpng libcurl pxcore-libnode

SPARK_CONF_OPTS += \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_WITH_TEXTURE_USAGE_MONITORING=ON \
    -DPXCORE_COMPILE_WARNINGS_AS_ERRORS=OFF \
    -DPXSCENE_COMPILE_WARNINGS_AS_ERRORS=OFF \
    -DCMAKE_SKIP_RPATH=ON \
    -DPXCORE_MATRIX_HELPERS=OFF \
    -DBUILD_PXWAYLAND_SHARED_LIB=OFF \
    -DBUILD_PXWAYLAND_STATIC_LIB=OFF \
    -DPREFER_SYSTEM_LIBRARIES=ON \
    -DDISABLE_TURBO_JPEG=ON \
    -DDISABLE_DEBUG_MODE=ON \
    -DSPARK_BACKGROUND_TEXTURE_CREATION=ON \
    -DSPARK_ENABLE_LRU_TEXTURE_EJECTION=OFF \
    -DSUPPORT_DUKTAPE=OFF \
    -DBUILD_DUKTAPE=ON \
    -DSPARK_ENABLE_OPTIMIZED_UPDATE=OFF \
    -DSPARK_BACKGROUND_TEXTURE_CREATION=OFF


ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR), y)
    SPARK_CONF_OPTS += \
        -DBUILD_WITH_WPEFRAMEWORK=ON \
        -DPXCORE_WPEFRAMEWORK=ON

    COMPOSITOR=wpeframework
    COMPOSITOR_BIN=wpe
    SPARK_DEPENDENCIES += wpeframework

else ifeq ($(BR2_PACKAGE_WESTEROS_ESSOS), y)
    SPARK_DEPENDENCIES += westeros

    SPARK_CONF_OPTS += \
        -DPXCORE_ESSOS=ON \
        -DBUILD_PXSCENE_ESSOS=ON

    COMPOSITOR=essos
    COMPOSITOR_BIN=egl

else
    SPARK_DEPENDENCIES += westeros

    SPARK_CONF_OPTS += \
        -DBUILD_WITH_WAYLAND=ON \
        -DBUILD_WITH_WESTEROS=ON \
        -DPXCORE_WAYLAND_EGL=ON \
        -DBUILD_PXSCENE_WAYLAND_EGL=ON

    COMPOSITOR=wayland_egl
    COMPOSITOR_BIN=egl

endif

ifeq ($(BR2_PACKAGE_SPARK_LIB), y)

SPARK_CONF_OPTS += \
    -DBUILD_PXSCENE_APP=OFF \
    -DBUILD_PXSCENE_STATIC_LIB=OFF \
    -DBUILD_PXSCENE_SHARED_LIB=ON
else

SPARK_CONF_OPTS += \
    -DBUILD_PXSCENE_APP_WITH_PXSCENE_LIB=ON
endif

SPARK_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -fno-delete-null-pointer-checks"

ifeq ($(BR2_PACKAGE_RTREMOTE), y)
SPARK_CONF_OPTS += \
    -DBUILD_OPTIMUS_STATIC_LIB=ON
SPARK_DEPENDENCIES += rtremote
else

SPARK_CONF_OPTS += \
    -DBUILD_RTCORE_LIBS=ON \
    -DBUILD_RTCORE_STATIC_LIB=OFF

define RTCORE_INSTALL_LIBS
    $(INSTALL) -m 755 $(@D)/build/$(COMPOSITOR_BIN)/librtCore.so $(1)/usr/lib/
endef
define RTCORE_INSTALL_INCLUDES
    mkdir -p $(STAGING_DIR)/usr/include/unix
    cp -Rpf $(@D)/src/unix/*.h $(STAGING_DIR)/usr/include/unix
endef

endif

ifeq ($(BR2_PACKAGE_SPACKAGE_PXCORE_LIBNODE_6), y)
SPARK_CONF_OPTS += -DUSE_NODE_8=OFF
else
#Apply pxCore lib node patch to get patched headers localy for NODE 8.15.1 case
PXCORE_LIBNODE_VER = 8.15.1
PXCORE_LIBNODE_PATH = examples/pxScene2d/external/
define PXCORE_LIBNODE_PATCHES
    cd $(@D); \
    patch -p1 <$(PXCORE_LIBNODE_PATH)/node-v$(PXCORE_LIBNODE_VER)_mods.patch
endef
endif

SPARK_PRE_PATCH_HOOKS = PXCORE_LIBNODE_PATCHES

SPARK_INSTALL_PATH = usr/share/WPEFramework/Spark
define SPARK_INSTALL_DEPS
    mkdir -p $(TARGET_DIR)/$(SPARK_INSTALL_PATH)
    cp -ar $(@D)/examples/pxScene2d/src/node_modules $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
    $(INSTALL) -m 755 $(@D)/examples/pxScene2d/src/*.js $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
    $(INSTALL) -m 755 $(@D)/examples/pxScene2d/src/*.json $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
    $(INSTALL) -m 755 $(@D)/examples/pxScene2d/src/*.ttf $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
    $(INSTALL) -m 755 $(@D)/examples/pxScene2d/src/sparkpermissions.conf $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
    $(INSTALL) -m 755 $(@D)/examples/pxScene2d/src/waylandregistry.conf $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
    cp -ar $(@D)/examples/pxScene2d/src/rcvrcore $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
    cp -ar $(@D)/examples/pxScene2d/src/browser $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
    cp -ar $(@D)/examples/pxScene2d/src/optimus $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
    cp -ar $(@D)/examples/pxScene2d/src/duk_modules $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
    cp -ar $(@D)/examples/pxScene2d/src/v8_modules $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
    cp -ar $(@D)/examples/pxScene2d/src/rasterizer $(TARGET_DIR)/$(SPARK_INSTALL_PATH)/
endef

ifeq ($(BR2_PACKAGE_SPARK_LIB), y)
define SPARK_INSTALL_PX_NATIVE_WINDOW
    mkdir -p $(STAGING_DIR)/usr/include/spark/$(COMPOSITOR)
    cp -ar $(@D)/src/$(COMPOSITOR)/*.h $(STAGING_DIR)/usr/include/spark/$(COMPOSITOR)
endef

define SPARK_INSTALL_STAGING_CMDS
    $(call RTCORE_INSTALL_LIBS, $(STAGING_DIR))
    cp -ar $(@D)/src/*.h $(STAGING_DIR)/usr/include/
    $(RTCORE_INSTALL_INCLUDES)
    mkdir -p $(STAGING_DIR)/usr/include/spark
    cp -ar $(@D)/examples/pxScene2d/src/*.h $(STAGING_DIR)/usr/include/spark/
    $(SPARK_INSTALL_PX_NATIVE_WINDOW)
    $(INSTALL) -D package/spark/Spark.pc $(STAGING_DIR)/usr/lib/pkgconfig/Spark.pc
    $(INSTALL) -m 755 $(@D)/examples/pxScene2d/src/libSpark.so $(STAGING_DIR)/usr/lib
endef

define SPARK_INSTALL_TARGET_CMDS
    $(SPARK_INSTALL_DEPS)
    $(call RTCORE_INSTALL_LIBS, $(TARGET_DIR))
    $(call SPARK_INSTALL_LIBS, $(TARGET_DIR))
    $(INSTALL) -m 755 $(@D)/examples/pxScene2d/src/libSpark.so $(TARGET_DIR)/usr/lib
endef

else

define SPARK_INSTALL_STAGING_CMDS
    $(call RTCORE_INSTALL_LIBS, $(TARGET_DIR))
    $(call SPARK_INSTALL_LIBS, $(STAGING_DIR))
endef

define SPARK_INSTALL_TARGET_CMDS
    $(SPARK_INSTALL_DEPS)
    $(call RTCORE_INSTALL_LIBS, $(TARGET_DIR))
    $(INSTALL) -m 755 $(@D)/examples/pxScene2d/src/Spark $(TARGET_DIR)/usr/bin
endef
endif
$(eval $(cmake-package))
