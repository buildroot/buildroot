KERNEL_MODULE_VERSION = master
KERNEL_MODULE_SITE = https://github.com/Seeed-Studio/seeed-linux-dtoverlays.git
KERNEL_MODULE_SITE_METHOD = git
KERNEL_MODULE_INSTALL_STAGING = NO
KERNEL_MODULE_INSTALL_TARGET = YES

define KERNEL_MODULE_BUILD_CMDS
	$(MAKE) ARCH="$(KERNEL_ARCH)" \
		CC="$(TARGET_CC)" \
		KBUILD="$(LINUX_DIR)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		-C $(@D) all_rpi
endef

define KERNEL_MODULE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/overlays/rpi/reTerminal-overlay.dtbo $(BINARIES_DIR)/rpi-firmware/roverlays/eTerminal.dtbo
	mkdir -p $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/
	$(MAKE) ARCH="$(KERNEL_ARCH)" CROSS_COMPILE="$(TARGET_CROSS)" KBUILD="$(LINUX_DIR)" KO_DIR="$(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/" -C $(@D) install_rpi
	$(HOST_DIR)/sbin/depmod -a -b $(TARGET_DIR) $(LINUX_VERSION_PROBED)
endef

$(eval $(generic-package))
