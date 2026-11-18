################################################################################
#
# mali-imx
#
################################################################################

MALI_IMX_REVISION = 18cb429
MALI_IMX_VERSION = r56p0.0
MALI_IMX_SITE = $(FREESCALE_IMX_SITE)
MALI_IMX_SOURCE = mali-imx-$(MALI_IMX_VERSION)-$(MALI_IMX_REVISION).bin

MALI_IMX_INSTALL_STAGING = YES

MALI_IMX_LICENSE = NXP Semiconductor Software License Agreement
MALI_IMX_LICENSE_FILES = EULA COPYING SCR.txt
MALI_IMX_REDISTRIBUTE = NO

MALI_IMX_PROVIDES = libgbm libegl libgles libopencl

MALI_IMX_DEPENDENCIES += libdrm wayland

define MALI_IMX_EXTRACT_CMDS
	$(call NXP_EXTRACT_HELPER,$(MALI_IMX_DL_DIR)/$(MALI_IMX_SOURCE))
endef

define MALI_IMX_INSTALL_STAGING_CMDS
	cp -a $(@D)/usr/lib/lib* $(STAGING_DIR)/usr/lib/
	cp -a $(@D)/usr/lib/pkgconfig/* $(STAGING_DIR)/usr/lib/pkgconfig/
	cp -a $(@D)/usr/include/* $(STAGING_DIR)/usr/include/
endef

ifeq ($(BR2_PACKAGE_MALI_IMX_COMPILERS),y)
MALI_IMX_DEPENDENCIES += host-patchelf

define MALI_IMX_INSTALL_COMPILERS
	cp -a $(@D)/usr/bin/* $(TARGET_DIR)/usr/bin/
	$(HOST_DIR)/bin/patchelf --set-interpreter /lib/ld-linux-aarch64.so.1 \
		$(TARGET_DIR)/usr/bin/mali*
endef
endif

define MALI_IMX_INSTALL_TARGET_CMDS
	cp -a $(@D)/usr/lib/lib* $(TARGET_DIR)/usr/lib/
	cp -a $(@D)/etc/* $(TARGET_DIR)/etc/
	mkdir -p $(TARGET_DIR)/lib/firmware/
	cp -a $(@D)/usr/lib/firmware/mali_csffw.bin \
		$(TARGET_DIR)/lib/firmware/
	$(MALI_IMX_INSTALL_COMPILERS)
endef

$(eval $(generic-package))
