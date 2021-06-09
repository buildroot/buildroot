################################################################################
#
# beaglev-ddrinit
#
################################################################################

# Commit on the 'starfive' branch
BEAGLEV_DDRINIT_VERSION = c0839f25246d9e308c23498d344ca13d8a7ad6ed
BEAGLEV_DDRINIT_SITE = $(call github,starfive-tech,beagle_ddrinit,$(BEAGLEV_DDRINIT_VERSION))
BEAGLEV_DDRINIT_INSTALL_TARGET = NO
BEAGLEV_DDRINIT_INSTALL_IMAGES = YES
BEAGLEV_DDRINIT_DEPENDENCIES = host-riscv64-elf-toolchain
BEAGLEV_DDRINIT_LICENSE = GPL-2.0+
BEAGLEV_DDRINIT_LICENSE_FILES = LICENSE

define BEAGLEV_DDRINIT_BUILD_CMDS
	$(MAKE) -C $(@D)/build \
		CROSSCOMPILE=$(HOST_DIR)/bin/riscv64-unknown-elf- \
		SUFFIX=buildroot \
		GIT_VERSION=$(BEAGLEV_DDRINIT_VERSION)
endef

define BEAGLEV_DDRINIT_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/build/ddrinit-2133-buildroot.bin.out \
		$(BINARIES_DIR)/ddrinit-2133-buildroot.bin.out
endef

$(eval $(generic-package))
