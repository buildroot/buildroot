################################################################################
#
# intelce-devmem
#
################################################################################
INTELCE_DEVMEM_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_DEVMEM_SITE = ${INTELCE_SDK_DIR}/devmem
INTELCE_DEVMEM_SITE_METHOD = local
INTELCE_DEVMEM_LICENSE = PROPRIETARY
INTELCE_DEVMEM_REDISTRIBUTE = NO
INTELCE_DEVMEM_DEPENDENCIES = intelce-sdk linux intelce-platform_config
INTELCE_DEVMEM_INSTALL_STAGING = YES

define INTELCE_DEVMEM_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_DEVMEM_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_DEVMEM_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
