################################################################################
#
# parodus2ccsp
#
################################################################################

PARODUS2CCSP_VERSION = 2fdffe0b783cef4beb5ca0232b4def4d63c87c45
PARODUS2CCSP_SITE_METHOD = git
PARODUS2CCSP_SITE = https://github.com/Comcast/parodus2ccsp
PARODUS2CCSP_INSTALL_STAGING = YES

PARODUS2CCSP_DEPENDENCIES = libparodus ccspcommonlibrary utopia

PARODUS2CCSP_CONF_OPTS = \
    -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(PARODUS2CCSP_INCLUDE_DIRS) -L$(STAGING_DIR)/lib -lpthread -L$(STAGING_DIR)/usr/lib -lsyscfg -lulog -D_DEBUG `pkg-config --libs libsafec`"\
    -DBUILD_BR=ON

ifeq ($(BR2_PACKAGE_PARODUS2CCSP_APP), y)
    PARODUS2CCSP_CONF_OPTS += -DPARODUS2CCSP_APP=true
endif

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE),y)
    PARODUS2CCSP_CONF_OPTS += -DBUILD_RASPBERRYPI=ON
endif

PARODUS2CCSP_INCLUDE_DIRS = \
    -I$(STAGING_DIR)/usr/include \
    -I$(STAGING_DIR)/usr/include/cjson \
    -I$(STAGING_DIR)/usr/include/wdmp-c \
    -I$(STAGING_DIR)/usr/include/wrp-c \
    -I$(STAGING_DIR)/usr/include/cimplog \
    -I$(STAGING_DIR)/usr/include/trower-base64 \
    -I$(STAGING_DIR)/usr/include/libparodus \
    -I$(STAGING_DIR)/usr/include/ccsp \
    -I$(STAGING_DIR)/usr/include/ccsp/linux \
    -I$(STAGING_DIR)/usr/include/dbus-1.0 \
    -I$(STAGING_DIR)/usr/lib/dbus-1.0/include


define PARODUS2CCSP_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/usr/ccsp/webpa
    cp -ar $(@D)/source/arch/intel_usg/boards/rdkb_atom/config/comcast/WebpaAgent.xml $(TARGET_DIR)/usr/ccsp/webpa
    cp -ar $(@D)/source/libwebpa.so $(TARGET_DIR)/usr/lib
endef

$(eval $(cmake-package))
