################################################################################
#
# intelce-core
#
################################################################################
INTELCE_CORE_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_CORE_SITE = ${INTELCE_SDK_DIR}/core
INTELCE_CORE_SITE_METHOD = local
INTELCE_CORE_LICENSE = PROPRIETARY
INTELCE_CORE_REDISTRIBUTE = NO
INTELCE_CORE_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-SMD_Common intelce-api intelce-platform_config intelce-intel_ce_pm
INTELCE_CORE_INSTALL_STAGING = YES

define INTELCE_CORE_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_CORE_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_CORE_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
