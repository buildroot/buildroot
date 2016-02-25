################################################################################
#
# intelce-sven
#
################################################################################
INTELCE_SVEN_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SVEN_SITE = ${INTELCE_SDK_DIR}/sven
INTELCE_SVEN_SITE_METHOD = local
INTELCE_SVEN_LICENSE = PROPRIETARY
INTELCE_SVEN_REDISTRIBUTE = NO
INTELCE_SVEN_INSTALL_STAGING = YES
INTELCE_SVEN_DEPENDENCIES = intelce-sdk linux intelce-htuple intelce-auto_eas intelce-osal intelce-pal intelce-platform_config intelce-SMD_Common
    
ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_SVEN_DEPENDENCIES +=  intelce-iosf
endif

define INTELCE_SVEN_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_SVEN_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_SVEN_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
