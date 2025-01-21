################################################################################
#
# xilinx-embeddedsw
#
################################################################################

XILINX_EMBEDDEDSW_VERSION = $(call qstrip,$(BR2_TARGET_XILINX_EMBEDDEDSW_VERSION))
XILINX_EMBEDDEDSW_SITE = $(call github,Xilinx,embeddedsw,$(XILINX_EMBEDDEDSW_VERSION))
XILINX_EMBEDDEDSW_LICENSE = MIT
XILINX_EMBEDDEDSW_LICENSE_FILES = license.txt
XILINX_EMBEDDEDSW_INSTALL_TARGET = NO
XILINX_EMBEDDEDSW_INSTALL_IMAGES = YES
XILINX_EMBEDDEDSW_DEPENDENCIES = toolchain-bare-metal-buildroot

# ZYNQMP_PMUFW application allows users to add cflags
XILINX_EMBEDDEDSW_ZYNQMP_PMUFW_USER_CFLAGS = \
	$(call qstrip,$(BR2_TARGET_XILINX_EMBEDDEDSW_ZYNQMP_PMUFW_USER_CFLAGS))
XILINX_EMBEDDEDSW_ZYNQMP_PMUFW_CFLAGS = \
	"-Os -flto -ffat-lto-objects $(XILINX_EMBEDDEDSW_ZYNQMP_PMUFW_USER_CFLAGS)"

XILINX_EMBEDDEDSW_CFLAGS = "-Os -flto -ffat-lto-objects"

ifeq ($(BR2_TARGET_XILINX_EMBEDDEDSW_VERSAL_PLM),y)
define XILINX_EMBEDDEDSW_BUILD_VERSAL_PLM
	$(MAKE) -C $(@D)/lib/sw_apps/versal_plm/src/versal \
		COMPILER=$(HOST_DIR)/bin/microblazeel-xilinx-elf-gcc \
		ARCHIVER=$(HOST_DIR)/bin/microblazeel-xilinx-elf-gcc-ar \
		CC=$(HOST_DIR)/bin/microblazeel-xilinx-elf-gcc \
		CFLAGS=$(XILINX_EMBEDDEDSW_CFLAGS)
endef

define XILINX_EMBEDDEDSW_INSTALL_VERSAL_PLM
	$(INSTALL) -D -m 0755 $(@D)/lib/sw_apps/versal_plm/src/versal/plm.elf \
		$(BINARIES_DIR)/plm.elf
endef
endif # BR2_TARGET_XILINX_EMBEDDEDSW_VERSAL_PLM

ifeq ($(BR2_TARGET_XILINX_EMBEDDEDSW_VERSAL_PSMFW),y)
define XILINX_EMBEDDEDSW_BUILD_VERSAL_PSMFW
	$(MAKE) -C $(@D)/lib/sw_apps/versal_psmfw/src/versal \
		COMPILER=$(HOST_DIR)/bin/microblazeel-xilinx-elf-gcc \
		ARCHIVER=$(HOST_DIR)/bin/microblazeel-xilinx-elf-gcc-ar \
		CC=$(HOST_DIR)/bin/microblazeel-xilinx-elf-gcc \
		CFLAGS=$(XILINX_EMBEDDEDSW_CFLAGS)
endef

define XILINX_EMBEDDEDSW_INSTALL_VERSAL_PSMFW
	$(INSTALL) -D -m 0755 $(@D)/lib/sw_apps/versal_psmfw/src/versal/psmfw.elf \
		$(BINARIES_DIR)/psmfw.elf
endef
endif # BR2_TARGET_XILINX_EMBEDDEDSW_VERSAL_PSMFW

ifeq ($(BR2_TARGET_XILINX_EMBEDDEDSW_ZYNQMP_PMUFW),y)
define XILINX_EMBEDDEDSW_BUILD_ZYNQMP_PMUFW
	$(MAKE) -C $(@D)/lib/sw_apps/zynqmp_pmufw/src \
		COMPILER=$(HOST_DIR)/bin/microblazeel-xilinx-elf-gcc \
		ARCHIVER=$(HOST_DIR)/bin/microblazeel-xilinx-elf-gcc-ar \
		CC=$(HOST_DIR)/bin/microblazeel-xilinx-elf-gcc \
		CFLAGS=$(XILINX_EMBEDDEDSW_ZYNQMP_PMUFW_CFLAGS)
endef

define XILINX_EMBEDDEDSW_INSTALL_ZYNQMP_PMUFW
	$(INSTALL) -D -m 0755 $(@D)/lib/sw_apps/zynqmp_pmufw/src/executable.elf \
		$(BINARIES_DIR)/pmufw.elf
endef
endif # BR2_TARGET_XILINX_EMBEDDEDSW_ZYNQMP_PMUFW

define XILINX_EMBEDDEDSW_BUILD_CMDS
	$(XILINX_EMBEDDEDSW_BUILD_VERSAL_PLM)
	$(XILINX_EMBEDDEDSW_BUILD_VERSAL_PSMFW)
	$(XILINX_EMBEDDEDSW_BUILD_ZYNQMP_PMUFW)
endef

define XILINX_EMBEDDEDSW_INSTALL_IMAGES_CMDS
	$(XILINX_EMBEDDEDSW_INSTALL_VERSAL_PLM)
	$(XILINX_EMBEDDEDSW_INSTALL_VERSAL_PSMFW)
	$(XILINX_EMBEDDEDSW_INSTALL_ZYNQMP_PMUFW)
endef

$(eval $(generic-package))
