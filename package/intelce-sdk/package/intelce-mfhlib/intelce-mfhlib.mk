################################################################################
#
# intelce-mfhlib
#
################################################################################
INTELCE_MFHLIB_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_MFHLIB_SITE = ${INTELCE_SDK_DIR}/mfhlib
INTELCE_MFHLIB_SITE_METHOD = local
INTELCE_MFHLIB_LICENSE = PROPRIETARY
INTELCE_MFHLIB_REDISTRIBUTE = NO
INTELCE_MFHLIB_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-pal intelce-nand_config intelce-flashtool openssl
INTELCE_MFHLIB_INSTALL_STAGING = YES
  
ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_MFHLIB_DEPENDENCIES += intelce-idtsal
endif

define INTELCE_MFHLIB_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_MFHLIB_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install
endef

define INTELCE_MFHLIB_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install
endef

$(eval $(generic-package))
