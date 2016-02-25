################################################################################
#
# intelce-vidpproc_fw
#
################################################################################
INTELCE_VIDPPROC_FW_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDPPROC_FW_SITE = ${INTELCE_SDK_DIR}/vidpproc_fw
INTELCE_VIDPPROC_FW_SITE_METHOD = local
INTELCE_VIDPPROC_FW_LICENSE = PROPRIETARY
INTELCE_VIDPPROC_FW_REDISTRIBUTE = NO
INTELCE_VIDPPROC_FW_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal linux intelce-platform_config intelce-smd_tools intelce-sven intelce-core intelce-SMD_Common intelce-htuple
INTELCE_VIDPPROC_FW_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_VIDPPROC_FW_DEPENDENCIES += intelce-fw_load 
endif

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_VIDPPROC_FW_DEPENDENCIES += intelce-ipclib
endif

define INTELCE_VIDPPROC_FW_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_VIDPPROC_FW_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install 
endef

define INTELCE_VIDPPROC_FW_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install  
endef

$(eval $(generic-package))
