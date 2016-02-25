################################################################################
#
# intelce-idts_security
#
################################################################################
INTELCE_IDTS_SECURITY_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IDTS_SECURITY_SITE = ${INTELCE_SDK_DIR}/idts_security
INTELCE_IDTS_SECURITY_SITE_METHOD = local
INTELCE_IDTS_SECURITY_LICENSE = PROPRIETARY
INTELCE_IDTS_SECURITY_REDISTRIBUTE = NO
INTELCE_IDTS_SECURITY_DEPENDENCIES = intelce-sdk intelce-pal intelce-osal intelce-nand_config intelce-flash_appdata intelce-sec openssl intelce-idts_common
INTELCE_IDTS_SECURITY_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_IDTS_COMMON_DEPENDENCIES += intelce-idtsal
endif

define INTELCE_IDTS_SECURITY_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_IDTS_SECURITY_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install
endef

define INTELCE_IDTS_SECURITY_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install
endef

$(eval $(generic-package))
