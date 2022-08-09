################################################################################
#
# telemetry
#
################################################################################

TELEMETRY_VERSION = 36e2d55d36242dd716eeb607667c90247cc8fa51
TELEMETRY_SITE_METHOD = git
TELEMETRY_SITE = https://code.rdkcentral.com/r/rdk/components/generic/telemetry
TELEMETRY_INSTALL_STAGING = YES
TELEMETRY_AUTORECONF = YES
TELEMETRY_DEPENDENCIES = rbus dbus cjson

TELEMETRY_CPPFLAGS = $(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include/dbus-1.0 -I$(STAGING_DIR)/usr/lib/dbus-1.0/include -I$(STAGING_DIR)/usr/include/cjson -I$(STAGING_DIR)/usr/include/rbus -D_DEBUG
TELEMETRY_CONF_ENV += CPPFLAGS="$(TELEMETRY_CPPFLAGS)"

TELEMETRY_MAKE_ENV = PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR)

define TELEMETRY_INSTALL_STAGING_CMDS
    mkdir -p $(STAGING_DIR)/usr/include/telemetry
    cp -ar $(@D)/include/* $(STAGING_DIR)/usr/include/telemetry
    cp -ar $(@D)/source/commonlib/.libs/libtelemetry_msgsender.so* $(STAGING_DIR)/usr/lib
    cp -ar $(@D)/source/utils/.libs/libutils.so* $(STAGING_DIR)/usr/lib
endef

$(eval $(autotools-package))
