################################################################################
#
# imx-mkimage
#
################################################################################

IMX_MKIMAGE_VERSION = lf-6.6.23-2.0.0
IMX_MKIMAGE_SITE = $(call github,nxp-imx,imx-mkimage,$(IMX_MKIMAGE_VERSION))
IMX_MKIMAGE_LICENSE = GPL-2.0+
IMX_MKIMAGE_LICENSE_FILES = LICENSE
HOST_IMX_MKIMAGE_DEPENDENCIES = host-zlib

ifeq ($(BR2_PACKAGE_FREESCALE_IMX_PLATFORM_IMX8M)$(BR2_PACKAGE_FREESCALE_IMX_PLATFORM_IMX8MM)$(BR2_PACKAGE_FREESCALE_IMX_PLATFORM_IMX8MN)$(BR2_PACKAGE_FREESCALE_IMX_PLATFORM_IMX8MP),y)
# i.MX8M needs a different binary
define HOST_IMX_MKIMAGE_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_CONFIGURE_OPTS) \
		CFLAGS="$(HOST_CFLAGS) -std=c99" \
		BUILD_LDFLAGS="$(HOST_LDFLAGS)" \
		-C $(@D)/iMX8M SOC_DIR=iMX8M -f soc.mak mkimage_imx8
endef
define HOST_IMX_MKIMAGE_INSTALL_CMDS
	$(INSTALL) -D -m 755 $(@D)/iMX8M/mkimage_imx8 $(HOST_DIR)/bin/mkimage_imx8
	$(INSTALL) -D -m 755 $(@D)/iMX8M/mkimage_fit_atf.sh $(HOST_DIR)/bin/mkimage_fit_atf.sh
	$(INSTALL) -D -m 755 $(@D)/iMX8M/print_fit_hab.sh $(HOST_DIR)/bin/print_fit_hab.sh
endef
else
# i.MX8, i.MX8X and i.MX9
define HOST_IMX_MKIMAGE_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_CONFIGURE_OPTS) \
		CFLAGS="$(HOST_CFLAGS) -std=c99" \
		-C $(@D) MKIMG=mkimage_imx8 mkimage_imx8
endef
define HOST_IMX_MKIMAGE_INSTALL_CMDS
	$(INSTALL) -D -m 755 $(@D)/mkimage_imx8 $(HOST_DIR)/bin/mkimage_imx8
endef
endif

$(eval $(host-generic-package))
