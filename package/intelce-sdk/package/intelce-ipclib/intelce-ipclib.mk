################################################################################
#
# intelce-ipclib
#
################################################################################
INTELCE_IPCLIB_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IPCLIB_SITE = ${INTELCE_SDK_DIR}/ipclib
INTELCE_IPCLIB_SITE_METHOD = local
INTELCE_IPCLIB_LICENSE = PROPRIETARY
INTELCE_IPCLIB_REDISTRIBUTE = NO
INTELCE_IPCLIB_DEPENDENCIES = intelce-sdk linux intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven intelce-SMD_Common
INTELCE_IPCLIB_INSTALL_STAGING = YES

define INTELCE_IPCLIB_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_IPCLIB_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_IPCLIB_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
