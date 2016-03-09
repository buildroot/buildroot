################################################################################
#
# intelce-expbus
#
################################################################################
INTELCE_EXPBUS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_EXPBUS_SITE = ${INTELCE_SDK_DIR}/expbus
INTELCE_EXPBUS_SITE_METHOD = local
INTELCE_EXPBUS_LICENSE = PROPRIETARY
INTELCE_EXPBUS_REDISTRIBUTE = NO
INTELCE_EXPBUS_DEPENDENCIES = intelce-sdk linux
INTELCE_EXPBUS_INSTALL_STAGING = YES

define INTELCE_EXPBUS_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_EXPBUS_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_EXPBUS_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
