################################################################################
#
# sema-linux
#
################################################################################

SEMA_LINUX_VERSION = v4.4.5
SEMA_LINUX_SITE = $(call github,ADLINK,sema-linux,$(SEMA_LINUX_VERSION))
SEMA_LINUX_LICENSE = BSD-3-Clause or GPL-2.0
SEMA_LINUX_LICENSE_FILES = LICENSE.BSD3 LICENSE.GPLv2 LICENSE.dual
SEMA_LINUX_DEPENDENCIES = util-linux

define SEMA_LINUX_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) app_build
endef

define SEMA_LINUX_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) -C $(@D) app_install
endef

define SEMA_LINUX_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_BACKLIGHT_CLASS_DEVICE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_GPIO_SYSFS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_GPIOLIB)
	$(call KCONFIG_ENABLE_OPT,CONFIG_HWMON)
	$(call KCONFIG_ENABLE_OPT,CONFIG_I2C)
	$(call KCONFIG_ENABLE_OPT,CONFIG_I2C_BOARDINFO)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NVMEM)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WATCHDOG)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WATCHDOG_CORE)
endef

$(eval $(kernel-module))
$(eval $(generic-package))
