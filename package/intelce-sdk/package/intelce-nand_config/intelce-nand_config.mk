################################################################################
#
# intelce-nand_config
#
################################################################################
INTELCE_NAND_CONFIG_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_NAND_CONFIG_SITE = ${INTELCE_SDK_DIR}/nand_config
INTELCE_NAND_CONFIG_SITE_METHOD = local
INTELCE_NAND_CONFIG_LICENSE = PROPRIETARY
INTELCE_NAND_CONFIG_REDISTRIBUTE = NO
INTELCE_NAND_CONFIG_DEPENDENCIES = intelce-sdk linux intelce-osal
INTELCE_NAND_CONFIG_INSTALL_STAGING = YES

define INTELCE_NAND_CONFIG_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_NAND_CONFIG_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
