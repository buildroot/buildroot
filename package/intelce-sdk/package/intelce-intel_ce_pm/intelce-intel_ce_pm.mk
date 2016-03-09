################################################################################
#
# intelce-intel_ce_pm
#
################################################################################
INTELCE_INTEL_CE_PM_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_INTEL_CE_PM_SITE = ${INTELCE_SDK_DIR}/intel_ce_pm
INTELCE_INTEL_CE_PM_SITE_METHOD = local
INTELCE_INTEL_CE_PM_LICENSE = PROPRIETARY
INTELCE_INTEL_CE_PM_REDISTRIBUTE = NO
INTELCE_INTEL_CE_PM_INSTALL_STAGING = YES
INTELCE_INTEL_CE_PM_DEPENDENCIES = intelce-sdk linux intelce-pal intelce-osal intelce-clock_control intelce-platform_config intelce-8051_SDK intelce-system_utils

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_INTEL_CE_PM_DEPENDENCIES += intelce-iosf
endif 

define INTELCE_INTEL_CE_PM_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) bld
endef

define INTELCE_INTEL_CE_PM_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_INTEL_CE_PM_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
