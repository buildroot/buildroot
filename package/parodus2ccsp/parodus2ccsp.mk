################################################################################
#
# parodus2ccsp
#
################################################################################

PARODUS2CCSP_VERSION = ac99ab5d95491640ef4c283959783de09d5a382a
PARODUS2CCSP_SITE_METHOD = git
PARODUS2CCSP_SITE = https://github.com/Comcast/parodus2ccsp
PARODUS2CCSP_INSTALL_STAGING = YES

PARODUS2CCSP_DEPENDENCIES = libparodus ccspcommonlibrary

PARODUS2CCSP_CONF_OPTS = \
        -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(PARODUS2CCSP_INCLUDE_DIRS)" \
        -DBUILD_BR=ON

ifeq ($(BR2_PACKAGE_PARODUS2CCSP_APP), y)
PARODUS2CCSP_CONF_OPTS += -DPARODUS2CCSP_APP=true
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
    -I${STAGING_DIR}/usr/include/dbus-1.0 \
    -I${STAGING_DIR}/usr/lib/dbus-1.0/include

$(eval $(cmake-package))
