################################################################################
#
# intelce-sec
#
################################################################################
INTELCE_SEC_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SEC_SITE = ${INTELCE_SDK_DIR}/sec
INTELCE_SEC_SITE_METHOD = local
INTELCE_SEC_LICENSE = PROPRIETARY
INTELCE_SEC_REDISTRIBUTE = NO
INTELCE_SEC_DEPENDENCIES = intelce-sdk intelce-auto_eas linux intelce-osal intelce-pal intelce-sven intelce-clock_control intelce-intel_ce_pm

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
     NTELCE_SEC_DEPENDENCIES += intelce-flash_appdata  
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_SEC_DEPENDENCIES += intelce-system_utils intelce-iosf
endif
INTELCE_SEC_INSTALL_STAGING = YES
    
define INTELCE_SEC_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) bld
endef

define INTELCE_SEC_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_SEC_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
