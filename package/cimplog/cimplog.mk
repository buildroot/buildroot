################################################################################
#
# cimplog
#
################################################################################

CIMPLOG_VERSION = 8b5c60f3930aa287121edd40c97915f692426a61
CIMPLOG_SITE_METHOD = git
CIMPLOG_SITE = https://github.com/Comcast/cimplog.git
CIMPLOG_INSTALL_STAGING = YES


ifeq ($(BR2_PACKAGE_CIMPLOG_SUPPORT_ONBOARD_LOGGING),y)
    CIMPLOG_CONF_OPTS += -DFEATURE_SUPPORT_ONBOARD_LOGGING=true
else
    CIMPLOG_CONF_OPTS += -DFEATURE_SUPPORT_ONBOARD_LOGGING=false
endif
CIMPLOG_CONF_OPTS += -DLEVEL_DEFAULT=$(BR2_PACKAGE_CIMPLOG_LEVEL_DEFAULT)


define CIMPLOG_INSTALL_TARGET_CMDS
    cp -ar $(@D)/src/libcimplog.so* $(TARGET_DIR)/usr/lib
endef
$(eval $(cmake-package))
