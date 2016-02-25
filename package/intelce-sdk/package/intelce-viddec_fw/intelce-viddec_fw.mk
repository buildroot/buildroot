################################################################################
#
# intelce-viddec_fw
#
################################################################################
INTELCE_VIDDEC_FW_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDDEC_FW_SITE = ${INTELCE_SDK_DIR}/viddec_fw
INTELCE_VIDDEC_FW_SITE_METHOD = local
INTELCE_VIDDEC_FW_LICENSE = PROPRIETARY
INTELCE_VIDDEC_FW_REDISTRIBUTE = NO
INTELCE_VIDDEC_FW_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal linux intelce-platform_config intelce-smd_tools intelce-sven intelce-core intelce-SMD_Common intelce-htuple
INTELCE_VIDDEC_FW_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_VIDPPROC_DEPENDENCIES += intelce-fw_load 
endif

define INTELCE_VIDDEC_FW_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_VIDDEC_FW_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install  
endef

define INTELCE_VIDDEC_FW_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install 
endef

$(eval $(generic-package))
