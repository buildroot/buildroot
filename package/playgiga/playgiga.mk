################################################################################
#
# PLAYGIGA
#
################################################################################

PLAYGIGA_VERSION = d8789e72d35c0ea68d70c1022a49ce1f10342bb2
PLAYGIGA_SITE_METHOD = git
PLAYGIGA_SITE = https://github.com/Metrological/playgiga
PLAYGIGA_INSTALL_STAGING = YES
PLAYGIGA_DEPENDENCIES = host-cmake gstreamer1 gst1-plugins-base \
	gst1-plugins-good gst1-plugins-bad libcurl opus wpeframework

PLATFORM_DIR = wpe

ifeq ($(BR2_PACKAGE_WESTEROS),y)
PLAYGIGA_DEPENDENCIES += westeros
ifeq ($(BR2_PACKAGE_WESTEROS_SINK),y)
PLAYGIGA_DEPENDENCIES += westeros-sink
PLAYGIGA_FLAGS += -DUSE_WESTEROS_SINK:BOOL=ON
else
PLAYGIGA_FLAGS += -DUSE_WESTEROS_SINK:BOOL=OFF
endif
endif

PLAYGIGA_CONF_OPTS = \
        $(PLAYGIGA_FLAGS)

ifeq ($(BR2_PACKAGE_PLAYGIGA_APP),y)
PLAYGIGA_CONF_OPTS += -DPLAYGIGA_APP=true
define PLAYGIGA_INSTALL_IMAGE
	cp -a $(@D)/bin/pgclient $(TARGET_DIR)/usr/bin
endef
else
PLAYGIGA_CONF_OPTS += -DPLAYGIGA_APP=false

define PLAYGIGA_INSTALL_IMAGE
		cp -a $(@D)/lib/libplaygiga.so $(TARGET_DIR)/usr/lib
endef

define PLAYGIGA_INSTALL_STAGING_IMAGE
		cp -a $(@D)/lib/libplaygiga.so $(STAGING_DIR)/usr/lib
endef
endif

#define PLAYGIGA_BUILD_CMDS
#	$(HOST_DIR)/usr/bin/cmake $(@D)/$(PLATFORM_DIR)/CMakeLists.txt \
#	-DBUILDROOT_HOST_PATH=$(HOST_DIR) $(PLAYGIGA_CONF_OPTS)
#	$(MAKE) -C $(@D)/$(PLATFORM_DIR)
#endef

define PLAYGIGA_INSTALL_TARGET_CMDS
	$(call PLAYGIGA_INSTALL_IMAGE)
endef

define PLAYGIGA_INSTALL_STAGING_CMDS
	$(call PLAYGIGA_INSTALL_STAGING_IMAGE)
endef


$(eval $(cmake-package))
