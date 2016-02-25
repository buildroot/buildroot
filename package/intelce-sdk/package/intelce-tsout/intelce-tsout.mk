################################################################################
#
# intelce-tsout
#
################################################################################
INTELCE_TSOUT_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_TSOUT_SITE = ${INTELCE_SDK_DIR}/tsout
INTELCE_TSOUT_SITE_METHOD = local
INTELCE_TSOUT_LICENSE = PROPRIETARY
INTELCE_TSOUT_REDISTRIBUTE = NO
INTELCE_TSOUT_DEPENDENCIES = intelce-sdk intelce-core intelce-pal intelce-platform_config intelce-auto_eas intelce-osal intelce-htuple intelce-system_utils intelce-common intelce-smd_tools intelce-sven linux intelce-SMD_Common intelce-api intelce-platform_config intelce-clock_control intelce-intel_ce_pm
INTELCE_TSOUT_INSTALL_STAGING = YES

define INTELCE_TSOUT_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_TSOUT_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_TSOUT_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
