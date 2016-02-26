################################################################################
#
# intelce-display
#
################################################################################
INTELCE_DISPLAY_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_DISPLAY_SITE = ${INTELCE_SDK_DIR}/display
INTELCE_DISPLAY_SITE_METHOD = local
INTELCE_DISPLAY_LICENSE = PROPRIETARY
INTELCE_DISPLAY_REDISTRIBUTE = NO
INTELCE_DISPLAY_INSTALL_STAGING = YES
INTELCE_DISPLAY_DEPENDENCIES = intelce-sdk intelce-sec intelce-core intelce-api intelce-auto_eas intelce-clock_control intelce-hdmi_hdcp intelce-idl linux intelce-osal intelce-pal intelce-platform_config intelce-system_utils intelce-sven intelce-generic_timer freetype libpng zlib intelce-intel_ce_pm

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_DISPLAY_DEPENDENCIES +=  intelce-iosf
endif

define INTELCE_DISPLAY_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) bld
endef

define INTELCE_DISPLAY_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
	$(INSTALL) -m 644 $(@D)/gdl.pc $(STAGING_DIR)/usr/lib/pkgconfig/gdl.pc
endef

define INTELCE_DISPLAY_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target 
endef

$(eval $(generic-package))
