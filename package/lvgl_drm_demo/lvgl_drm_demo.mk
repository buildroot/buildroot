################################################################################
#
# lvgl
#
################################################################################


LVGL_DRM_DEMO_VERSION = 245161f37d63a538499c61f574c7943d29a89a5a
LVGL_DRM_DEMO_SITE = https://github.com/lvgl/lv_port_linux_frame_buffer
LVGL_DRM_DEMO_SITE_METHOD = git
LVGL_DRM_DEMO_GIT_SUBMODULES = YES
LVGL_DRM_DEMO_LICENSE = MIT
LVGL_DRM_DEMO_LICENSE_FILES = LICENCE
LVGL_DRM_DEMO_INSTALL_STAGING = YES
LVGL_DRM_DEMO_DEPENDENCIES += libdrm libinput eudev


define LVGL_DRM_DEMO_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)"\
	 -C $(@D)
endef

define LVGL_DRM_DEMO_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D \
		$(@D)/demo \
		$(TARGET_DIR)/usr/bin/lvgl_demo
endef


$(eval $(generic-package))
