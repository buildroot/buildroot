################################################################################
#
# intelce-mspod
#
################################################################################
INTELCE_MSPOD_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_MSPOD_SITE = ${INTELCE_SDK_DIR}/mspod
INTELCE_MSPOD_SITE_METHOD = local
INTELCE_MSPOD_LICENSE = PROPRIETARY
INTELCE_MSPOD_REDISTRIBUTE = NO
INTELCE_MSPOD_DEPENDENCIES = intelce-sdk linux intelce-auto_eas intelce-osal intelce-idl intelce-flash_appdata intelce-sven intelce-core
INTELCE_MSPOD_INSTALL_STAGING = YES

define INTELCE_MSPOD_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_MSPOD_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_MSPOD_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
