################################################################################
#
# rpi-firmware
#
################################################################################

RPI_FIRMWARE_VERSION = 3f20b832b27cd730deb6419b570f31a98167eef6
RPI_FIRMWARE_SITE = $(call github,raspberrypi,firmware,$(RPI_FIRMWARE_VERSION))
RPI_FIRMWARE_LICENSE = BSD-3-Clause
RPI_FIRMWARE_LICENSE_FILES = boot/LICENCE.broadcom
RPI_FIRMWARE_INSTALL_IMAGES = YES

RPI_FIRMWARE_FILES = \
	$(if $(BR2_PACKAGE_RPI_FIRMWARE_BOOTCODE_BIN), bootcode.bin) \
	$(if $(BR2_PACKAGE_RPI_FIRMWARE_VARIANT_PI), start.elf fixup.dat) \
	$(if $(BR2_PACKAGE_RPI_FIRMWARE_VARIANT_PI_X), start_x.elf fixup_x.dat) \
	$(if $(BR2_PACKAGE_RPI_FIRMWARE_VARIANT_PI_CD), start_cd.elf fixup_cd.dat) \
	$(if $(BR2_PACKAGE_RPI_FIRMWARE_VARIANT_PI_DB), start_db.elf fixup_db.dat) \
	$(if $(BR2_PACKAGE_RPI_FIRMWARE_VARIANT_PI4), start4.elf fixup4.dat) \
	$(if $(BR2_PACKAGE_RPI_FIRMWARE_VARIANT_PI4_X), start4x.elf fixup4x.dat) \
	$(if $(BR2_PACKAGE_RPI_FIRMWARE_VARIANT_PI4_CD), start4cd.elf fixup4cd.dat) \
	$(if $(BR2_PACKAGE_RPI_FIRMWARE_VARIANT_PI4_DB), start4db.elf fixup4db.dat)

define RPI_FIRMWARE_INSTALL_BIN
	$(foreach f,$(RPI_FIRMWARE_FILES), \
		$(INSTALL) -D -m 0644 $(@D)/boot/$(f) $(BINARIES_DIR)/rpi-firmware/$(f)
	)
endef

RPI_FIRMWARE_CONFIG_FILE = $(call qstrip,$(BR2_PACKAGE_RPI_FIRMWARE_CONFIG_FILE))
ifneq ($(RPI_FIRMWARE_CONFIG_FILE),)
define RPI_FIRMWARE_INSTALL_CONFIG
	$(INSTALL) -D -m 0644 $(RPI_FIRMWARE_CONFIG_FILE) \
		$(BINARIES_DIR)/rpi-firmware/config.txt
endef
endif

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE_INSTALL_DTBS),y)
define RPI_FIRMWARE_INSTALL_DTB
	$(foreach dtb,$(wildcard $(@D)/boot/*.dtb), \
		$(INSTALL) -D -m 0644 $(dtb) $(BINARIES_DIR)/rpi-firmware/$(notdir $(dtb))
	)
endef
endif

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE_INSTALL_DTB_OVERLAYS),y)
define RPI_FIRMWARE_INSTALL_DTB_OVERLAYS
	$(foreach ovldtb,$(wildcard $(@D)/boot/overlays/*.dtbo), \
		$(INSTALL) -D -m 0644 $(ovldtb) $(BINARIES_DIR)/rpi-firmware/overlays/$(notdir $(ovldtb))
	)
	$(INSTALL) -D -m 0644 $(@D)/boot/overlays/overlay_map.dtb $(BINARIES_DIR)/rpi-firmware/overlays/
endef
else
# Still create the directory, so a genimage.cfg can include it independently of
# whether _INSTALL_DTB_OVERLAYS is selected or not.
define RPI_FIRMWARE_INSTALL_DTB_OVERLAYS
	$(INSTALL) -d $(BINARIES_DIR)/rpi-firmware/overlays
endef
endif

# Install prebuilt libraries if RPI_USERLAND not enabled
ifneq ($(BR2_PACKAGE_RPI_USERLAND),y)
define RPI_FIRMWARE_INSTALL_TARGET_LIB
	$(INSTALL) -D -m 0644 $(@D)/$(if BR2_ARM_EABIHF,hardfp/)opt/vc/lib/libvcos.so \
		$(TARGET_DIR)/usr/lib/libvcos.so
	$(INSTALL) -D -m 0644 $(@D)/$(if BR2_ARM_EABIHF,hardfp/)opt/vc/lib/libdebug_sym.so \
		$(TARGET_DIR)/usr/lib/libdebug_sym.so
endef
endif

ifeq ($(BR2_PACKAGE_RPI_FIRMWARE_INSTALL_VCDBG),y)
define RPI_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0700 $(@D)/$(if BR2_ARM_EABIHF,hardfp/)opt/vc/bin/vcdbg \
		$(TARGET_DIR)/usr/sbin/vcdbg
	$(INSTALL) -D -m 0644 $(@D)/$(if BR2_ARM_EABIHF,hardfp/)opt/vc/lib/libelftoolchain.so \
		$(TARGET_DIR)/usr/lib/libelftoolchain.so
	$(RPI_FIRMWARE_INSTALL_TARGET_LIB)
endef
endif # INSTALL_VCDBG

define RPI_FIRMWARE_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 package/rpi-firmware/cmdline.txt $(BINARIES_DIR)/rpi-firmware/cmdline.txt
	$(RPI_FIRMWARE_INSTALL_BIN)
	$(RPI_FIRMWARE_INSTALL_CONFIG)
	$(RPI_FIRMWARE_INSTALL_DTB)
	$(RPI_FIRMWARE_INSTALL_DTB_OVERLAYS)
endef

$(eval $(generic-package))
