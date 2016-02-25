################################################################################
#
# intelce-hdmi_hdcp
#
################################################################################
INTELCE_HDMI_HDCP_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_HDMI_HDCP_SITE = ${INTELCE_SDK_DIR}/hdmi_hdcp
INTELCE_HDMI_HDCP_SITE_METHOD = local
INTELCE_HDMI_HDCP_LICENSE = PROPRIETARY
INTELCE_HDMI_HDCP_REDISTRIBUTE = NO
INTELCE_HDMI_HDCP_DEPENDENCIES = intelce-sdk openssl intelce-flashtool intelce-sec intelce-osal intelce-pal intelce-flash_appdata
INTELCE_HDMI_HDCP_INSTALL_STAGING = YES

define INTELCE_HDMI_HDCP_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) bld
endef

define INTELCE_HDMI_HDCP_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_HDMI_HDCP_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
