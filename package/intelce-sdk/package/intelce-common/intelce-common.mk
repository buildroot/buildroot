################################################################################
#
# intelce-common
#
################################################################################
INTELCE_COMMON_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_COMMON_SITE = ${INTELCE_SDK_DIR}/common
INTELCE_COMMON_SITE_METHOD = local
INTELCE_COMMON_LICENSE = PROPRIETARY
INTELCE_COMMON_REDISTRIBUTE = NO
INTELCE_COMMON_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-clock intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-core intelce-api intelce-SMD_Common
INTELCE_COMMON_INSTALL_STAGING = YES

define INTELCE_COMMON_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_COMMON_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_COMMON_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
