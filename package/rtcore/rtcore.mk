################################################################################
#
# rtcore
#
################################################################################
RTCORE_VERSION = 65b261180bd189248bd3c69933fb369109080dcf
RTCORE_SITE_METHOD = git
RTCORE_SITE = git://github.com/pxscene/pxCore
RTCORE_INSTALL_STAGING = YES

export HOSTNAME = "raspberrypi"

RTCORE_CONF_OPTS += \
    -DBUILD_PXCORE_LIBS=OFF \
    -DBUILD_PXSCENE=OFF \
    -DHOSTNAME=raspberrypi \
    -DBUILD_RTCORE_LIBS=ON \
    -DBUILD_RTCORE_STATIC_LIB=OFF

define RTCORE_INSTALL_STAGING_CMDS
    mkdir -p $(STAGING_DIR)/usr/include/unix
    cp -Rpf $(@D)/src/*.h $(STAGING_DIR)/usr/include/
    cp -Rpf $(@D)/src/unix/*.h $(STAGING_DIR)/usr/include/unix
    $(INSTALL) -m 755 $(@D)/build/egl/librtCore*.so $(STAGING_DIR)/usr/lib/
endef

define RTCORE_INSTALL_TARGET_CMDS
    make -C $(@D) preinstall
    $(INSTALL) -m 755 $(@D)/build/egl/librtCore*.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(cmake-package))
