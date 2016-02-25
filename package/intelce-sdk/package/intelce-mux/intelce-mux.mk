################################################################################
#
# intelce-mux
#
################################################################################
INTELCE_MUX_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_MUX_SITE = ${INTELCE_SDK_DIR}/mux
INTELCE_MUX_SITE_METHOD = local
INTELCE_MUX_LICENSE = PROPRIETARY
INTELCE_MUX_REDISTRIBUTE = NO
INTELCE_MUX_DEPENDENCIES = intelce-sdk intelce-video_ces intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-intel_ce_pm
INTELCE_MUX_INSTALL_STAGING = YES

define INTELCE_MUX_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_MUX_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_MUX_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
