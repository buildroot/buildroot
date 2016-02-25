################################################################################
#
# intelce-generic_timer
#
################################################################################
INTELCE_GENERIC_TIMER_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_GENERIC_TIMER_SITE = ${INTELCE_SDK_DIR}/generic_timer
INTELCE_GENERIC_TIMER_SITE_METHOD = local
INTELCE_GENERIC_TIMER_LICENSE = PROPRIETARY
INTELCE_GENERIC_TIMER_REDISTRIBUTE = NO
INTELCE_GENERIC_TIMER_DEPENDENCIES = intelce-sdk intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config
INTELCE_GENERIC_TIMER_INSTALL_STAGING = YES

define INTELCE_GENERIC_TIMER_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_GENERIC_TIMER_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_GENERIC_TIMER_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
