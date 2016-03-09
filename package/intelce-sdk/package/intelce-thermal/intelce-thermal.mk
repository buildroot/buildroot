################################################################################
#
# intelce-thermal
#
################################################################################
INTELCE_THERMAL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_THERMAL_SITE = ${INTELCE_SDK_DIR}/thermal
INTELCE_THERMAL_SITE_METHOD = local
INTELCE_THERMAL_LICENSE = PROPRIETARY
INTELCE_THERMAL_REDISTRIBUTE = NO
INTELCE_THERMAL_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-pal
INTELCE_THERMAL_INSTALL_STAGING = YES

define INTELCE_THERMAL_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_THERMAL_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_THERMAL_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
