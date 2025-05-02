################################################################################
#
# xilinx-fpgautil
#
################################################################################

XILINX_FPGAUTIL_VERSION = xlnx-rel-v2024.2_update3
XILINX_FPGAUTIL_SITE = $(call github,Xilinx,meta-xilinx,$(XILINX_FPGAUTIL_VERSION))
XILINX_FPGAUTIL_LICENSE = MIT
XILINX_FPGAUTIL_LICENSE_FILES = COPYING.MIT

define XILINX_FPGAUTIL_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CC) $(TARGET_LDFLAGS) \
		$(@D)/meta-xilinx-core/recipes-bsp/fpga-manager-script/files/fpgautil.c \
		-o $(@D)/fpgautil
endef

define XILINX_FPGAUTIL_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/fpgautil $(TARGET_DIR)/usr/bin/fpgautil
endef

$(eval $(generic-package))
