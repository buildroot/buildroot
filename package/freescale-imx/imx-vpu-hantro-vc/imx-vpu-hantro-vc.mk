################################################################################
#
# imx-vpu-hantro-vc
#
################################################################################

IMX_VPU_HANTRO_VC_VERSION = 1.4.0
IMX_VPU_HANTRO_VC_SITE = $(FREESCALE_IMX_SITE)
IMX_VPU_HANTRO_VC_SOURCE = imx-vpu-hantro-vc-$(IMX_VPU_HANTRO_VC_VERSION).bin
IMX_VPU_HANTRO_VC_DEPENDENCIES = linux

IMX_VPU_HANTRO_VC_LICENSE = NXP Semiconductor Software License Agreement
IMX_VPU_HANTRO_VC_LICENSE_FILES = EULA COPYING
IMX_VPU_HANTRO_VC_REDISTRIBUTE = NO

define IMX_VPU_HANTRO_VC_EXTRACT_CMDS
	$(call FREESCALE_IMX_EXTRACT_HELPER,$(IMX_VPU_HANTRO_VC_DL_DIR)/$(IMX_VPU_HANTRO_VC_SOURCE))
endef

define IMX_VPU_HANTRO_VC_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/usr/lib/libhantro_vc8000e.so $(TARGET_DIR)/usr/lib/libhantro_vc8000e.so
	$(INSTALL) -D -m 0755 $(@D)/usr/lib/libhantro_vc8000e.so.1 $(TARGET_DIR)/usr/lib/libhantro_vc8000e.so.1
endef

$(eval $(generic-package))
