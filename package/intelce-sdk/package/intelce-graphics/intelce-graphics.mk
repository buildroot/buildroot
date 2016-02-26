################################################################################
#
# intelce-graphics
#
################################################################################
INTELCE_GRAPHICS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_GRAPHICS_SITE = ${INTELCE_SDK_DIR}/graphics
INTELCE_GRAPHICS_SITE_METHOD = local
INTELCE_GRAPHICS_LICENSE = PROPRIETARY
INTELCE_GRAPHICS_REDISTRIBUTE = NO
INTELCE_GRAPHICS_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-pal intelce-display host-bison host-flex libdrm
INTELCE_GRAPHICS_INSTALL_STAGING = YES

define INTELCE_GRAPHICS_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) bld
endef

define INTELCE_GRAPHICS_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
    $(INSTALL) -m 644 $(@D)/egl.pc $(STAGING_DIR)/usr/lib/pkgconfig/egl.pc
	$(INSTALL) -m 644 $(@D)/glesv2.pc $(STAGING_DIR)/usr/lib/pkgconfig/glesv2.pc    
endef

define INTELCE_GRAPHICS_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef


$(eval $(generic-package))
