################################################################################
#
# wilc-driver
#
################################################################################

WILC_DRIVER_VERSION = linux4microchip-2021.10-1
WILC_DRIVER_SITE = $(call github,embeddedTS,wilc3000-external-module,$(WILC_DRIVER_VERSION))

WILC_DRIVER_LICENSE = GPL-2.0
WILC_DRIVER_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_WILC_DRIVER_SPI),y)
WILC_DRIVER_MODULE_MAKE_OPTS += \
	CONFIG_WILC_SPI=m
endif

ifeq ($(BR2_PACKAGE_WILC_DRIVER_SDIO),y)
WILC_DRIVER_MODULE_MAKE_OPTS += \
	CONFIG_WILC_SDIO=m
endif

ifeq ($(BR2_PACKAGE_WILC_DRIVER_SDIO_OOB),y)
WILC_DRIVER_MODULE_MAKE_OPTS += \
	CONFIG_WILC_HW_OOB_INTR=y
endif

$(eval $(kernel-module))
$(eval $(generic-package))
