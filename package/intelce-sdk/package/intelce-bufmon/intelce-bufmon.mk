################################################################################
#
# intelce-bufmon
#
################################################################################
INTELCE_BUFMON_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_BUFMON_SITE = ${INTELCE_SDK_DIR}/bufmon
INTELCE_BUFMON_SITE_METHOD = local
INTELCE_BUFMON_LICENSE = PROPRIETARY
INTELCE_BUFMON_REDISTRIBUTE = NO
INTELCE_BUFMON_DEPENDENCIES = intelce-sdk intelce-api intelce-core intelce-pal intelce-osal intelce-auto_eas intelce-sven intelce-htuple intelce-system_utils intelce-platform_config intelce-common intelce-smd_tools linux intelce-SMD_Common intelce-clock_recovery
INTELCE_BUFMON_INSTALL_STAGING = YES


define INTELCE_BUFMON_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_BUFMON_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_BUFMON_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
