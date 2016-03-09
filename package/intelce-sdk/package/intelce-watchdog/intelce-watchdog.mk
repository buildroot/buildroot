################################################################################
#
# intelce-watchdog
#
################################################################################
INTELCE_WATCHDOG_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_WATCHDOG_SITE = ${INTELCE_SDK_DIR}/watchdog
INTELCE_WATCHDOG_SITE_METHOD = local
INTELCE_WATCHDOG_LICENSE = PROPRIETARY
INTELCE_WATCHDOG_REDISTRIBUTE = NO
INTELCE_WATCHDOG_DEPENDENCIES = intelce-sdk
INTELCE_WATCHDOG_INSTALL_STAGING = YES

define INTELCE_WATCHDOG_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_WATCHDOG_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install
endef

define INTELCE_WATCHDOG_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install
endef

$(eval $(generic-package))
