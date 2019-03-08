################################################################################
#
# rtcore
#
################################################################################
RTCORE_VERSION = cbb16e1c6a4166175aaf178d7e9c15b617d35d7a
RTCORE_SITE_METHOD = git
RTCORE_SITE = git://github.com/pxscene/pxCore
RTCORE_INSTALL_STAGING = YES
RTCORE_AUTORECONF = YES
RTCORE_AUTORECONF_OPTS = "-Icfg"

#RTCORE_DEPENDENCIES = openssl freetype westeros util-linux libpng libcurl

RTCORE_CONF_OPTS += \
    -DBUILD_RTCORE_LIBS=ON \
    -DBUILD_PXCORE_LIBS=OFF \
    -DBUILD_PXSCENE=OFF

define RTCORE_INSTALL_STAGING_CMDS
    make -C $(@D) preinstall
    mkdir -p $(STAGING_DIR)/usr/include/unix
    cp -Rpf $(@D)/src/*.h $(STAGING_DIR)/usr/include/
    cp -Rpf $(@D)/src/unix/*.h $(STAGING_DIR)/usr/include/unix
endef
define RTCORE_INSTALL_TARGET_CMDS
        make -C $(@D) preinstall
endef

$(eval $(cmake-package))
