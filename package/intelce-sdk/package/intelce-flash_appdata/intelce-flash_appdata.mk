################################################################################
#
# intelce-flash_appdata
#
################################################################################
INTELCE_FLASH_APPDATA_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_FLASH_APPDATA_SITE = ${INTELCE_SDK_DIR}/flash_appdata
INTELCE_FLASH_APPDATA_SITE_METHOD = local
INTELCE_FLASH_APPDATA_LICENSE = PROPRIETARY
INTELCE_FLASH_APPDATA_REDISTRIBUTE = NO
INTELCE_FLASH_APPDATA_INSTALL_STAGING = YES

INTELCE_FLASH_APPDATA_DEPENDENCIES = intelce-sdk intelce-flashtool intelce-nand_config intelce-osal intelce-pal intelce-mfhlib

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_FLASH_APPDATA_DEPENDENCIES +=  intelce-idtsal
endif

define INTELCE_FLASH_APPDATA_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_FLASH_APPDATA_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install
endef

define INTELCE_FLASH_APPDATA_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install
endef

$(eval $(generic-package))
