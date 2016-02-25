################################################################################
#
# intelce-videnc
#
################################################################################
INTELCE_VIDENC_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDENC_SITE = ${INTELCE_SDK_DIR}/videnc
INTELCE_VIDENC_SITE_METHOD = local
INTELCE_VIDENC_LICENSE = PROPRIETARY
INTELCE_VIDENC_REDISTRIBUTE = NO
INTELCE_VIDENC_DEPENDENCIES = intelce-sdk intelce-video_ces intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-intel_ce_pm
INTELCE_VIDENC_INSTALL_STAGING = YES

define INTELCE_VIDENC_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_VIDENC_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev   
endef

define INTELCE_VIDENC_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target 
endef

$(eval $(generic-package))
