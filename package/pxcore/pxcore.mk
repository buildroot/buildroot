################################################################################
#
# pxcore
#
################################################################################
PXCORE_VERSION = 0db82d484abadebadeb3d8253b5a55924bcebaf8
PXCORE_VERSION = cbb16e1c6a4166175aaf178d7e9c15b617d35d7a
PXCORE_VERSION = 65b261180bd189248bd3c69933fb369109080dcf
PXCORE_SITE_METHOD = git
PXCORE_SITE = git://github.com/pxscene/pxCore
PXCORE_INSTALL_STAGING = YES

PXCORE_DEPENDENCIES = openssl freetype westeros util-linux libpng libcurl rtremote pxcore-tools pxcore-libnode

export HOSTNAME = "raspberrypi"

PXCORE_CONF_OPTS += \
    -DBUILD_WITH_WAYLAND=ON \
    -DBUILD_WITH_WESTEROS=ON \
    -DBUILD_WITH_TEXTURE_USAGE_MONITORING=ON \
    -DPXCORE_COMPILE_WARNINGS_AS_ERRORS=OFF \
    -DPXSCENE_COMPILE_WARNINGS_AS_ERRORS=OFF \
    -DCMAKE_SKIP_RPATH=ON \
    -DPXCORE_WAYLAND_EGL=ON \
    -DBUILD_PXSCENE_WAYLAND_EGL=ON \
    -DPXCORE_MATRIX_HELPERS=OFF \
    -DBUILD_PXWAYLAND_SHARED_LIB=OFF \
    -DBUILD_PXWAYLAND_STATIC_LIB=OFF \
    -DBUILD_PXSCENE_APP_WITH_PXSCENE_LIB=ON \
    -DPXCORE_ESSOS=ON \
    -DBUILD_PXSCENE_ESSOS=ON \
    -DPREFER_SYSTEM_LIBRARIES=ON \
    -DDISABLE_TURBO_JPEG=ON \
    -DDISABLE_DEBUG_MODE=ON \
    -DBUILD_OPTIMUS_STATIC_LIB=ON \
    -DSPARK_BACKGROUND_TEXTURE_CREATION=ON \
    -DSPARK_ENABLE_LRU_TEXTURE_EJECTION=OFF \
    -DHOSTNAME=raspberrypi \
    -DBUILD_RTCORE_LIBS=OFF

define PXCORE_INSTALL_LIBS
    $(INSTALL) -m 755 $(@D)/build/egl/libpxCore.so $(1)/usr/lib/
    $(INSTALL) -m 755 $(@D)/examples/pxScene2d/src/liboptimus.so $(1)/usr/lib/
endef

define PXCORE_INSTALL_STAGING_CMDS
    make -C $(@D) preinstall
    $(call PXCORE_INSTALL_LIBS, $(STAGING_DIR))
endef

define PXCORE_INSTALL_TARGET_CMDS
    make -C $(@D) preinstall
    $(call PXCORE_INSTALL_LIBS, $(TARGET_DIR))
    $(INSTALL) -m 755 $(@D)/examples/pxScene2d/src/Spark $(TARGET_DIR)/usr/bin
endef

$(eval $(cmake-package))
