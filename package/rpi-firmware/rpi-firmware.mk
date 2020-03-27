################################################################################
#
# rpi-firmware
#
################################################################################
RPI_FIRMWARE_VERSION = e10b2880e26708afc0b32a485c1231207037fc45
RPI_FIRMWARE_SITE = $(call github,raspberrypi,firmware,$(RPI_FIRMWARE_VERSION))
RPI_FIRMWARE_LICENSE = BSD-3c
RPI_FIRMWARE_LICENSE_FILES = boot/LICENCE.broadcom
RPI_FIRMWARE_INSTALL_IMAGES = YES

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE_INSTALL_DTBS),y)
define RPI_FIRMWARE_INSTALL_DTB
	$(foreach dtb,$(wildcard $(@D)/boot/*.dtb), \
		$(INSTALL) -D -m 0644 $(dtb) $(BINARIES_DIR)/rpi-firmware/$(notdir $(dtb))
	)
endef
endif

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE_INSTALL_DTB_OVERLAYS),y)
define RPI_FIRMWARE_INSTALL_DTB_OVERLAYS
	for ovldtb in  $(@D)/boot/overlays/*.dtbo; do \
		$(INSTALL) -D -m 0644 $${ovldtb} $(BINARIES_DIR)/rpi-firmware/overlays/$${ovldtb##*/} || exit 1; \
	done
endef
endif

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE_INSTALL_VCDBG),y)
define RPI_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0700 $(@D)/$(if BR2_ARM_EABIHF,hardfp/)opt/vc/bin/vcdbg \
		$(TARGET_DIR)/usr/sbin/vcdbg
endef
endif # INSTALL_VCDBG

ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_14),y)
define RPI_FIRMWARE_MOUNT_BOOT
	mkdir -p $(TARGET_DIR)/boot
	grep -q '^/dev/mmcblk1p1' $(TARGET_DIR)/etc/fstab || \
		echo -e '/dev/mmcblk0p1 /boot vfat defaults 0 0' >> $(TARGET_DIR)/etc/fstab
endef
define RPI_FIRMWARE_CMDLINE
	$(INSTALL) -D -m 0644 package/rpi-firmware/cmdline.txt-1 $(BINARIES_DIR)/rpi-firmware/cmdline.txt
endef
else
define RPI_FIRMWARE_MOUNT_BOOT
	mkdir -p $(TARGET_DIR)/boot
	grep -q '^/dev/mmcblk0p1' $(TARGET_DIR)/etc/fstab || \
		echo -e '/dev/mmcblk0p1 /boot vfat defaults 0 0' >> $(TARGET_DIR)/etc/fstab
endef
define RPI_FIRMWARE_CMDLINE
	$(INSTALL) -D -m 0644 package/rpi-firmware/cmdline.txt-0 $(BINARIES_DIR)/rpi-firmware/cmdline.txt
endef
endif

ifeq ($(BR2_TARGET_ROOTFS_CPIO),y)
ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_14),y)
define RPI_FIRMWARE_MOUNT_ROOT
	mkdir -p $(TARGET_DIR)/root
	grep -q '^/dev/mmcblk1p2' $(TARGET_DIR)/etc/fstab || \
		echo -e '/dev/mmcblk1p2 /root ext4 defaults 0 0' >> $(TARGET_DIR)/etc/fstab
	$(INSTALL) -m 0755 -D package/rpi-firmware/S30mountroot-1 \
		$(TARGET_DIR)/etc/init.d/S30mountroot
endef
else
define RPI_FIRMWARE_MOUNT_ROOT
	mkdir -p $(TARGET_DIR)/root
	grep -q '^/dev/mmcblk0p2' $(TARGET_DIR)/etc/fstab || \
		echo -e '/dev/mmcblk0p2 /root ext4 defaults 0 0' >> $(TARGET_DIR)/etc/fstab
	$(INSTALL) -m 0755 -D package/rpi-firmware/S30mountroot-0 \
		$(TARGET_DIR)/etc/init.d/S30mountroot
endef
endif
endif

ifeq ($(BR2_PACKAGE_RPI_VERSION_RPI4),y)
# bootcode.bin is not used on rpi4, because it has been replaced by boot code in the onboard EEPROM
define RPI_FIRMWARE_INSTALL_BOOT
	$(INSTALL) -D -m 0644 $(@D)/boot/start4$(BR2_PACKAGE_RPI_FIRMWARE_BOOT).elf $(BINARIES_DIR)/rpi-firmware/start4.elf
	$(INSTALL) -D -m 0644 $(@D)/boot/fixup4$(BR2_PACKAGE_RPI_FIRMWARE_BOOT).dat $(BINARIES_DIR)/rpi-firmware/fixup4.dat
endef
else
define RPI_FIRMWARE_INSTALL_BOOT
	$(INSTALL) -D -m 0644 $(@D)/boot/bootcode.bin $(BINARIES_DIR)/rpi-firmware/bootcode.bin
	$(INSTALL) -D -m 0644 $(@D)/boot/start$(BR2_PACKAGE_RPI_FIRMWARE_BOOT).elf $(BINARIES_DIR)/rpi-firmware/start.elf
	$(INSTALL) -D -m 0644 $(@D)/boot/fixup$(BR2_PACKAGE_RPI_FIRMWARE_BOOT).dat $(BINARIES_DIR)/rpi-firmware/fixup.dat
endef
endif

define RPI_FIRMWARE_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 package/rpi-firmware/config.txt $(BINARIES_DIR)/rpi-firmware/config.txt
	$(RPI_FIRMWARE_CMDLINE)
	$(RPI_FIRMWARE_MOUNT_BOOT)
	$(RPI_FIRMWARE_MOUNT_ROOT)
	$(RPI_FIRMWARE_INSTALL_BOOT)
	$(RPI_FIRMWARE_INSTALL_DTB)
	$(RPI_FIRMWARE_INSTALL_DTB_OVERLAYS)
endef

$(eval $(generic-package))
