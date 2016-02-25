################################################################################
#
# intelce-flashtool
#
################################################################################
INTELCE_FLASHTOOL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_FLASHTOOL_SITE = ${INTELCE_SDK_DIR}/flashtool
INTELCE_FLASHTOOL_SITE_METHOD = local
INTELCE_FLASHTOOL_LICENSE = PROPRIETARY
INTELCE_FLASHTOOL_REDISTRIBUTE = NO
INTELCE_FLASHTOOL_DEPENDENCIES = intelce-sdk linux
INTELCE_FLASHTOOL_INSTALL_STAGING = YES

define INTELCE_FLASHTOOL_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) bld
endef

define INTELCE_FLASHTOOL_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_FLASHTOOL_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
