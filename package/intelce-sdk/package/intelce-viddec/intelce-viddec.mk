################################################################################
#
# intelce-viddec
#
################################################################################
INTELCE_VIDDEC_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDDEC_SITE = ${INTELCE_SDK_DIR}/viddec
INTELCE_VIDDEC_SITE_METHOD = local
INTELCE_VIDDEC_LICENSE = PROPRIETARY
INTELCE_VIDDEC_REDISTRIBUTE = NO
INTELCE_VIDDEC_DEPENDENCIES = intelce-sdk intelce-viddec_fw intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-video_ces intelce-intel_ce_pm
INTELCE_VIDDEC_INSTALL_STAGING = YES

define INTELCE_VIDDEC_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_VIDDEC_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_VIDDEC_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target 
endef

$(eval $(generic-package))
