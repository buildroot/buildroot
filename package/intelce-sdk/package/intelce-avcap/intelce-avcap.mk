################################################################################
#
# intelce-avcap
#
################################################################################
INTELCE_AVCAP_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_AVCAP_SITE = ${INTELCE_SDK_DIR}/avcap
INTELCE_AVCAP_SITE_METHOD = local
INTELCE_AVCAP_LICENSE = PROPRIETARY
INTELCE_AVCAP_REDISTRIBUTE = NO
INTELCE_AVCAP_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-idl intelce-core intelce-platform_config intelce-display intelce-intel_ce_pm intelce-sven intelce-clock_control intelce-system_utils
INTELCE_AVCAP_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_AVCAP_DEPENDENCIES +=  intelce-iosf
endif

define INTELCE_AVCAP_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) bld
endef

define INTELCE_AVCAP_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_AVCAP_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
