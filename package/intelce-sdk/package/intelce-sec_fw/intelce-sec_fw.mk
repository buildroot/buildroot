################################################################################
#
# intelce-sec_fw
#
################################################################################
INTELCE_SEC_FW_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SEC_FW_SITE = ${INTELCE_SDK_DIR}/sec_fw
INTELCE_SEC_FW_SITE_METHOD = local
INTELCE_SEC_FW_LICENSE = PROPRIETARY
INTELCE_SEC_FW_REDISTRIBUTE = NO
INTELCE_SEC_FW_DEPENDENCIES = intelce-sdk intelce-sec intelce-flash_appdata intelce-osal intelce-pal expat host-expat intelce-config_database
INTELCE_SEC_FW_INSTALL_STAGING = YES

define INTELCE_SEC_FW_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_SEC_FW_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_SEC_FW_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
