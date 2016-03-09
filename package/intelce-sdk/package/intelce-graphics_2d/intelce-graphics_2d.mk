################################################################################
#
# intelce-graphics_2d
#
################################################################################
INTELCE_GRAPHICS_2D_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_GRAPHICS_2D_SITE = ${INTELCE_SDK_DIR}/graphics_2d
INTELCE_GRAPHICS_2D_SITE_METHOD = local
INTELCE_GRAPHICS_2D_LICENSE = PROPRIETARY
INTELCE_GRAPHICS_2D_REDISTRIBUTE = NO
INTELCE_GRAPHICS_2D_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-pal intelce-platform_config intelce-display intelce-graphics intelce-system_utils
INTELCE_GRAPHICS_2D_INSTALL_STAGING = YES

define INTELCE_GRAPHICS_2D_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) BUILD_ROOT=$(@D) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_GRAPHICS_2D_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) BUILD_ROOT=$(@D) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_GRAPHICS_2D_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) BUILD_ROOT=$(@D) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
