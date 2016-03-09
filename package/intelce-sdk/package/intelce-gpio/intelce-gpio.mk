################################################################################
#
# intelce-gpio
#
################################################################################
INTELCE_GPIO_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_GPIO_SITE = ${INTELCE_SDK_DIR}/gpio
INTELCE_GPIO_SITE_METHOD = local
INTELCE_GPIO_LICENSE = PROPRIETARY
INTELCE_GPIO_REDISTRIBUTE = NO
INTELCE_GPIO_DEPENDENCIES = intelce-sdk linux
INTELCE_GPIO_INSTALL_STAGING = YES

define INTELCE_GPIO_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_GPIO_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_GPIO_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
