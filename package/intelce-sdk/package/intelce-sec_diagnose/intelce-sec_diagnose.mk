################################################################################
#
# intelce-sec_diagnose
#
################################################################################
INTELCE_SEC_DIAGNOSE_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SEC_DIAGNOSE_SITE = ${INTELCE_SDK_DIR}/sec_diagnose
INTELCE_SEC_DIAGNOSE_SITE_METHOD = local
INTELCE_SEC_DIAGNOSE_LICENSE = PROPRIETARY
INTELCE_SEC_DIAGNOSE_REDISTRIBUTE = NO
INTELCE_SEC_DIAGNOSE_DEPENDENCIES = intelce-sdk intelce-osal intelce-pal intelce-flashtool intelce-flash_appdata intelce-sec intelce-hdmi_hdcp
INTELCE_SEC_DIAGNOSE_INSTALL_STAGING = YES

define INTELCE_SEC_DIAGNOSE_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) bld 
endef

define INTELCE_SEC_DIAGNOSE_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev  
endef

define INTELCE_SEC_DIAGNOSE_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target  
endef

$(eval $(generic-package))
