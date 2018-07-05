################################################################################
#
# PLAYGIGA
#
################################################################################

PLAYGIGA_VERSION = 6386e7ff7eabb4835da4c62ecfe4f5dd83521fea
PLAYGIGA_SITE_METHOD = git
PLAYGIGA_SITE = https://github.com/Metrological/playgiga
PLAYGIGA_INSTALL_STAGING = YES
PLAYGIGA_DEPENDENCIES = host-cmake gstreamer1 gst1-plugins-base \
	gst1-plugins-good gst1-plugins-bad libcurl opus

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

define PLAYGIGA_INSTALL_IMAGE
	cp -a $(@D)/$(PLATFORM_DIR)/bin/pgclient $(TARGET_DIR)/usr/bin
endef

define PLAYGIGA_BUILD_CMDS
	$(HOST_DIR)/usr/bin/cmake $(@D)/$(PLATFORM_DIR)/CMakeLists.txt \
	-DBUILDROOT_HOST_PATH=$(HOST_DIR) $(PLAYGIGA_CONF_OPTS)
	$(MAKE) -C $(@D)/$(PLATFORM_DIR)
endef

define PLAYGIGA_INSTALL_TARGET_CMDS
	$(call PLAYGIGA_INSTALL_IMAGE)
endef

$(eval $(generic-package))
