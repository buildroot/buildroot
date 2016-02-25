################################################################################
#
# intelce-api
#
################################################################################
INTELCE_API_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_API_SITE = ${INTELCE_SDK_DIR}/api
INTELCE_API_SITE_METHOD = local
INTELCE_API_LICENSE = PROPRIETARY
INTELCE_API_REDISTRIBUTE = NO
INTELCE_API_DEPENDENCIES = intelce-sdk intelce-SMD_Common
INTELCE_API_INSTALL_STAGING = YES

define INTELCE_API_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_API_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_API_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target 
endef

$(eval $(generic-package))
