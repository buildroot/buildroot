################################################################################
#
# intelce-clock
#
################################################################################
INTELCE_CLOCK_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_CLOCK_SITE = ${INTELCE_SDK_DIR}/clock
INTELCE_CLOCK_SITE_METHOD = local
INTELCE_CLOCK_LICENSE = PROPRIETARY
INTELCE_CLOCK_REDISTRIBUTE = NO
INTELCE_CLOCK_INSTALL_STAGING = YES
INTELCE_CLOCK_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-clock_control

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_CLOCK_DEPENDENCIES +=  intelce-iosf
endif

define INTELCE_CLOCK_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_CLOCK_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_CLOCK_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
