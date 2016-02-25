################################################################################
#
# intelce-system_utils
#
################################################################################
INTELCE_SYSTEM_UTILS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SYSTEM_UTILS_SITE = ${INTELCE_SDK_DIR}/system_utils
INTELCE_SYSTEM_UTILS_SITE_METHOD = local
INTELCE_SYSTEM_UTILS_LICENSE = PROPRIETARY
INTELCE_SYSTEM_UTILS_REDISTRIBUTE = NO
INTELCE_SYSTEM_UTILS_DEPENDENCIES = intelce-sdk intelce-osal linux intelce-SMD_Common intelce-pal intelce-sven
INTELCE_SYSTEM_UTILS_INSTALL_STAGING = YES

define INTELCE_SYSTEM_UTILS_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_SYSTEM_UTILS_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_SYSTEM_UTILS_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
