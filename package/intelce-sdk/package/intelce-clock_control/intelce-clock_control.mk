################################################################################
#
# intelce-clock_control
#
################################################################################
INTELCE_CLOCK_CONTROL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_CLOCK_CONTROL_SITE = ${INTELCE_SDK_DIR}/clock_control
INTELCE_CLOCK_CONTROL_SITE_METHOD = local
INTELCE_CLOCK_CONTROL_LICENSE = PROPRIETARY
INTELCE_CLOCK_CONTROL_REDISTRIBUTE = NO
INTELCE_CLOCK_CONTROL_DEPENDENCIES = intelce-sdk intelce-sven linux intelce-idl intelce-osal intelce-pal intelce-platform_config
INTELCE_CLOCK_CONTROL_INSTALL_STAGING = YES

define INTELCE_CLOCK_CONTROL_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) bld
endef

define INTELCE_CLOCK_CONTROL_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_CLOCK_CONTROL_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
