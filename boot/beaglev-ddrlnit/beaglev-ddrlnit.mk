################################################################################
#
# beaglev-ddrlnit
#
################################################################################

# Commit on the 'starfive' branch
BEAGLEV_DDRLNIT_VERSION = 15b80de81263996affb2a29332aa681925709983
BEAGLEV_DDRLNIT_SITE = $(call github,starfive-tech,beagle_ddrlnit,$(BEAGLEV_DDRLNIT_VERSION))
BEAGLEV_DDRLNIT_INSTALL_TARGET = NO
BEAGLEV_DDRLNIT_INSTALL_IMAGES = YES
BEAGLEV_DDRLNIT_DEPENDENCIES = host-riscv64-elf-toolchain
# unfortunately, no real license file, but several sources files are
# under GPL-2.0+, making the whole work GPL-2.0+
BEAGLEV_DDRLNIT_LICENSE = GPL-2.0+

define BEAGLEV_DDRLNIT_BUILD_CMDS
	$(MAKE) -C $(@D)/build \
		CROSSCOMPILE=$(HOST_DIR)/bin/riscv64-unknown-elf- \
		SUFFIX=buildroot \
		GIT_VERSION=$(BEAGLEV_DDRLNIT_VERSION)
endef

define BEAGLEV_DDRLNIT_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/build/ddrinit-2133-buildroot.bin.out \
		$(BINARIES_DIR)/ddrinit-2133-buildroot.bin.out
endef

$(eval $(generic-package))
