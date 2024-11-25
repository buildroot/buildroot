################################################################################
#
# imx-vpu-hantro-daemon
#
################################################################################

IMX_VPU_HANTRO_DAEMON_VERSION = 1.1.9
IMX_VPU_HANTRO_DAEMON_SITE = $(FREESCALE_IMX_SITE)
IMX_VPU_HANTRO_DAEMON_LICENSE = NXP Semiconductor Software License Agreement
IMX_VPU_HANTRO_DAEMON_LICENSE_FILES = LICENSE.txt
IMX_VPU_HANTRO_DAEMON_REDISTRIBUTE = NO
IMX_VPU_HANTRO_DAEMON_DEPENDENCIES = imx-vpu-hantro linux
ifeq ($(BR2_PACKAGE_FREESCALE_IMX_PLATFORM_IMX8MP),y)
IMX_VPU_HANTRO_DAEMON_DEPENDENCIES += imx-vpu-hantro-vc
endif

IMX_VPU_HANTRO_DAEMON_MAKE_ENV = \
	$(TARGET_MAKE_ENV) \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	SDKTARGETSYSROOT=$(STAGING_DIR) \
	LINUX_KERNEL_ROOT=$(LINUX_DIR) \
	CTRLSW_HDRPATH="$(STAGING_DIR)/usr/include" \
	PLATFORM=$(BR2_PACKAGE_FREESCALE_IMX_PLATFORM)

define IMX_VPU_HANTRO_DAEMON_BUILD_CMDS
	$(MAKE) -C $(@D) $(IMX_VPU_HANTRO_DAEMON_MAKE_ENV)
endef

define IMX_VPU_HANTRO_DAEMON_INSTALL_TARGET_CMDS
	$(IMX_VPU_HANTRO_DAEMON_MAKE_ENV) $(MAKE) -C $(@D) \
		DEST_DIR=$(TARGET_DIR) libdir=/usr/lib install
endef

$(eval $(generic-package))
