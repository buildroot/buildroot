################################################################################
#
# intelce-platform_config
#
################################################################################
INTELCE_PLATFORM_CONFIG_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_PLATFORM_CONFIG_SITE = ${INTELCE_SDK_DIR}/platform_config
INTELCE_PLATFORM_CONFIG_SITE_METHOD = local
INTELCE_PLATFORM_CONFIG_LICENSE = PROPRIETARY
INTELCE_PLATFORM_CONFIG_REDISTRIBUTE = NO
INTELCE_PLATFORM_CONFIG_DEPENDENCIES = intelce-sdk linux intelce-htuple openssl
INTELCE_PLATFORM_CONFIG_INSTALL_STAGING = YES

define INTELCE_PLATFORM_CONFIG_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_PLATFORM_CONFIG_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_PLATFORM_CONFIG_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
