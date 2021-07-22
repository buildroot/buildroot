################################################################################
#
# lvgl
#
################################################################################


LVGL_VERSION = 245161f37d63a538499c61f574c7943d29a89a5a
LVGL_SITE = https://github.com/lvgl/lv_port_linux_frame_buffer
LVGL_SITE_METHOD = git
LVGL_GIT_SUBMODULES = YES
LVGL_LICENSE = MIT
LVGL_LICENSE_FILES = LICENCE
LVGL_INSTALL_STAGING = YES
LVGL_DEPENDENCIES += libdrm libinput eudev


define LVGL_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)"\
	 -C $(@D)
endef

define LVGL_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D \
		$(@D)/demo \
		$(TARGET_DIR)/usr/bin/lvgl_demo
endef


$(eval $(generic-package))
