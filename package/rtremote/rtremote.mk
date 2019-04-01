################################################################################
#
# rtRemote
#
################################################################################
RTREMOTE_VERSION = 3db90b4881a2022f6222addbf6506419c4c2c281
RTREMOTE_SITE_METHOD = git
RTREMOTE_SITE = git://github.com/pxscene/rtRemote
RTREMOTE_INSTALL_STAGING = YES
RTREMOTE_AUTORECONF = YES
RTREMOTE_AUTORECONF_OPTS = "-Icfg"
RTREMOTE_DEPENDENCIES = host-rtremote rtcore

RTREMOTE_CONF_OPTS += \
    -DBUILD_RTREMOTE_LIBS=ON \
    -DBUILD_RTREMOTE_STATIC_LIB=OFF

HOST_RTREMOTE_CONF_OPTS += \
    -DBUILD_RTREMOTE_LIBS=OFF

define HOST_RTREMOTE_INSTALL_CMDS
    $(INSTALL) -m 755 $(@D)/rtRemoteConfigGen $(HOST_DIR)/usr/bin
endef

define RTREMOTE_INSTALL_STAGING_CMDS
    cp -Rpf $(@D)/include/rtRemote.h $(STAGING_DIR)/usr/include/
    $(INSTALL) -m 755 $(@D)/librtRemote.so $(STAGING_DIR)/usr/lib/
endef

define RTREMOTE_INSTALL_TARGET_CMDS
    $(INSTALL) -m 755 $(@D)/librtRemote.so $(TARGET_DIR)/usr/lib/
endef

$(eval $(host-cmake-package))
$(eval $(cmake-package))
