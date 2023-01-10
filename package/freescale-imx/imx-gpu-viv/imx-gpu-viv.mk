################################################################################
#
# imx-gpu-viv
#
################################################################################

ifeq ($(BR2_aarch64),y)
IMX_GPU_VIV_VERSION = 6.4.3.p4.4-aarch64
else
IMX_GPU_VIV_VERSION = 6.4.3.p4.4-aarch32
endif
IMX_GPU_VIV_SITE = $(FREESCALE_IMX_SITE)
IMX_GPU_VIV_SOURCE = imx-gpu-viv-$(IMX_GPU_VIV_VERSION).bin

IMX_GPU_VIV_INSTALL_STAGING = YES

IMX_GPU_VIV_LICENSE = NXP Semiconductor Software License Agreement
IMX_GPU_VIV_LICENSE_FILES = EULA COPYING
IMX_GPU_VIV_REDISTRIBUTE = NO

IMX_GPU_VIV_PROVIDES = libegl libgles libopencl libopenvg

ifeq ($(BR2_aarch64),y)
IMX_GPU_VIV_PROVIDES += libgbm
endif

IMX_GPU_VIV_LIB_TARGET = $(call qstrip,$(BR2_PACKAGE_IMX_GPU_VIV_OUTPUT))

# Libraries are linked against libdrm, except framebuffer output on ARM
ifneq ($(IMX_GPU_VIV_LIB_TARGET)$(BR2_arm),fby)
IMX_GPU_VIV_DEPENDENCIES += libdrm
endif

ifeq ($(IMX_GPU_VIV_LIB_TARGET),wayland)
IMX_GPU_VIV_DEPENDENCIES += wayland
endif

define IMX_GPU_VIV_EXTRACT_CMDS
	$(call NXP_EXTRACT_HELPER,$(IMX_GPU_VIV_DL_DIR)/$(IMX_GPU_VIV_SOURCE))
endef

ifeq ($(IMX_GPU_VIV_LIB_TARGET),fb)
define IMX_GPU_VIV_FIXUP_PKGCONFIG
	ln -sf egl_linuxfb.pc $(@D)/gpu-core/usr/lib/pkgconfig/egl.pc
endef
else ifeq ($(IMX_GPU_VIV_LIB_TARGET),wayland)
define IMX_GPU_VIV_FIXUP_PKGCONFIG
	ln -sf egl_wayland.pc $(@D)/gpu-core/usr/lib/pkgconfig/egl.pc
endef
endif

IMX_GPU_VIV_PLATFORM_DIR = $(call qstrip,$(BR2_PACKAGE_IMX_GPU_VIV_PLATFORM))
ifneq ($(IMX_GPU_VIV_PLATFORM_DIR),)
define IMX_GPU_VIV_COPY_PLATFORM
	cp -dpfr $(@D)/gpu-core/usr/lib/$(IMX_GPU_VIV_PLATFORM_DIR)/* $(@D)/gpu-core/usr/lib/
endef
endif

# Instead of building, we fix up the inconsistencies that exist
# in the upstream archive here. We also remove unused backend files.
# Make sure these commands are idempotent.
define IMX_GPU_VIV_BUILD_CMDS
	cp -dpfr $(@D)/gpu-core/usr/lib/$(IMX_GPU_VIV_LIB_TARGET)/* $(@D)/gpu-core/usr/lib/
	$(foreach backend,fb wayland, \
		$(RM) -r $(@D)/gpu-core/usr/lib/$(backend)
	)
	$(IMX_GPU_VIV_COPY_PLATFORM)
	$(foreach platform,mx8mn mx8mp mx8mq mx8qm mx8qxp mx8ulp, \
		$(RM) -r $(@D)/gpu-core/usr/lib/$(platform)
	)
	$(IMX_GPU_VIV_FIXUP_PKGCONFIG)
endef

define IMX_GPU_VIV_INSTALL_STAGING_CMDS
	cp -r $(@D)/gpu-core/usr/* $(STAGING_DIR)/usr
endef

ifeq ($(BR2_PACKAGE_IMX_GPU_VIV_EXAMPLES),y)
define IMX_GPU_VIV_INSTALL_EXAMPLES
	mkdir -p $(TARGET_DIR)/usr/share/examples/
	cp -r $(@D)/gpu-demos/opt/* $(TARGET_DIR)/usr/share/examples/
endef
endif

ifeq ($(BR2_PACKAGE_IMX_GPU_VIV_GMEM_INFO),y)
define IMX_GPU_VIV_INSTALL_GMEM_INFO
	cp -dpfr $(@D)/gpu-tools/gmem-info/usr/bin/* $(TARGET_DIR)/usr/bin/
endef
endif

define IMX_GPU_VIV_INSTALL_TARGET_CMDS
	$(IMX_GPU_VIV_INSTALL_EXAMPLES)
	$(IMX_GPU_VIV_INSTALL_GMEM_INFO)
	cp -a $(@D)/gpu-core/usr/lib $(TARGET_DIR)/usr
	$(INSTALL) -D -m 0644 $(@D)/gpu-core/etc/Vivante.icd $(TARGET_DIR)/etc/OpenCL/vendors/Vivante.icd
endef

$(eval $(generic-package))
