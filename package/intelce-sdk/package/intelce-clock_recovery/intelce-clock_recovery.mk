################################################################################
#
# intelce-clock_recovery
#
################################################################################
INTELCE_CLOCK_RECOVERY_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_CLOCK_RECOVERY_SITE = ${INTELCE_SDK_DIR}/clock_recovery
INTELCE_CLOCK_RECOVERY_SITE_METHOD = local
INTELCE_CLOCK_RECOVERY_LICENSE = PROPRIETARY
INTELCE_CLOCK_RECOVERY_REDISTRIBUTE = NO
INTELCE_CLOCK_RECOVERY_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-clock
INTELCE_CLOCK_RECOVERY_INSTALL_STAGING = YES

define INTELCE_CLOCK_RECOVERY_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_CLOCK_RECOVERY_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_CLOCK_RECOVERY_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
