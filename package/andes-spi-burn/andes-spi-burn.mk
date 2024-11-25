################################################################################
#
# andes-spi-burn
#
################################################################################

ANDES_SPI_BURN_VERSION = 5b8193c35360febd8445cfa32adc6b13a861616d
ANDES_SPI_BURN_SITE = $(call github,andestech,IntelJ3,$(ANDES_SPI_BURN_VERSION))
ANDES_SPI_BURN_LICENSE = Apache-2.0
ANDES_SPI_BURN_FILES = LICENSE

define HOST_ANDES_SPI_BURN_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) -f Makefile_SPIburn
endef

define HOST_ANDES_SPI_BURN_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/SPI_burn $(HOST_DIR)/bin/SPI_burn
endef

$(eval $(host-generic-package))
