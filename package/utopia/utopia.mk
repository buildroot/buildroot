################################################################################
#
# Utopia
#
################################################################################

UTOPIA_VERSION = 2173ef621df472162671f5ed8d0878df28fc112c
UTOPIA_SITE_METHOD = git
UTOPIA_SITE = https://code.rdkcentral.com/r/rdkb/components/opensource/ccsp/Utopia
UTOPIA_INSTALL_STAGING = YES
UTOPIA_AUTORECONF = YES
UTOPIA_DEPENDENCIES = ccspcommonlibrary safeclib telemetry

UTOPIA_CONF_OPTS = \
    --prefix=/usr/ \
    --includedir=$(STAGING_DIR)/usr/include \
    --enable-dslite_feature_support=no \
    --enable-rdk_feature_support=no

UTOPIA_CPPFLAGS = $(TARGET_CXXFLAGS) -I$(STAGING_DIR)/usr/include/dbus-1.0 -I$(STAGING_DIR)/usr/lib/dbus-1.0/include -I$(STAGING_DIR)/usr/include/ccsp -I$(STAGING_DIR)/usr/include/libsafec -I$(STAGING_DIR)/usr/include/telemetry -D_DEBUG
UTOPIA_MAKE_ENV = PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR)

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE),y)
#UTOPIA_CPPFLAGS += -D_ANSC_LINUX
endif

UTOPIA_CONF_ENV += CPPFLAGS="$(UTOPIA_CPPFLAGS)"
UTOPIA_LIBS = -lpthread
UTOPIA_LIBS += `pkg-config --libs libsafec`
UTOPIA_CONF_ENV += LIBS="${UTOPIA_LIBS}"

define UTOPIA_INSTALL_PACKAGE
    cp -ar $(@D)/source/syscfg/lib/.libs/libsyscfg.so* $(1)/usr/lib
    cp -ar $(@D)/source/ulog/.libs/libulog.so* $(1)/usr/lib
endef

define UTOPIA_INSTALL_STAGING_CMDS
    $(call UTOPIA_INSTALL_PACKAGE,$(STAGING_DIR))
    rm -rf $(@D)/source/syscfg/lib/.libs/libsyscfg.la
    cp -ar $(@D)/source/syscfg/lib/libsyscfg.la $(@D)/source/syscfg/lib/.libs/
    cp -ar $(@D)/source/include/syscfg $(STAGING_DIR)/usr/include
endef

define UTOPIA_INSTALL_TARGET_CMDS
    $(call UTOPIA_INSTALL_PACKAGE,$(TARGET_DIR))
    cp -ar $(@D)/source/syscfg/cmd/syscfg $(TARGET_DIR)/usr/bin
    ln -sf syscfg $(TARGET_DIR)/usr/bin/syscfg_create
    $(INSTALL) -D package/utopia/syscfg.db $(TARGET_DIR)/usr/ccsp
endef

$(eval $(autotools-package))
