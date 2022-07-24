################################################################################
#
# beaglev-secondboot
#
################################################################################

# Commit on the 'starfive' branch
BEAGLEV_SECONDBOOT_VERSION = e17302063c9a4b74475b18ff24dd149c27257354
BEAGLEV_SECONDBOOT_SITE = $(call github,starfive-tech,beagle_secondBoot,$(BEAGLEV_SECONDBOOT_VERSION))
BEAGLEV_SECONDBOOT_INSTALL_TARGET = NO
BEAGLEV_SECONDBOOT_INSTALL_IMAGES = YES
BEAGLEV_SECONDBOOT_DEPENDENCIES = host-riscv64-elf-toolchain
BEAGLEV_SECONDBOOT_LICENSE = GPL-2.0+
BEAGLEV_SECONDBOOT_LICENSE_FILES = LICENSE

define BEAGLEV_SECONDBOOT_BUILD_CMDS
	$(MAKE) -C $(@D)/build \
		CROSS_COMPILE=$(HOST_DIR)/bin/riscv64-unknown-elf- \
		SUFFIX=buildroot \
		GIT_VERSION=$(BEAGLEV_SECONDBOOT_VERSION)
endef

define BEAGLEV_SECONDBOOT_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/build/bootloader-JH7100-buildroot.bin.out \
		$(BINARIES_DIR)/bootloader-JH7100-buildroot.bin.out
endef

$(eval $(generic-package))
