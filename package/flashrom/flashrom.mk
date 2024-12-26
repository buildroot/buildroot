################################################################################
#
# flashrom
#
################################################################################

FLASHROM_VERSION = 1.5.1
FLASHROM_SITE = $(call github,flashrom,flashrom,v$(FLASHROM_VERSION))
FLASHROM_LICENSE = GPL-2.0+
FLASHROM_LICENSE_FILES = COPYING
FLASHROM_INSTALL_STAGING = YES
FLASHROM_CONF_OPTS = \
	-Dclassic_cli=enabled \
	-Dich_descriptors_tool=enabled \
	-Dtests=disabled \
	-Duse_internal_dmi=true \
	-Dwerror=false \
	-Dman-pages=disabled \
	-Ddocumentation=disabled

FLASHROM_PROGRAMMERS = \
	buspirate_spi \
	linux_mtd \
	linux_spi \
	parade_lspcon \
	mediatek_i2c_spi \
	mstarddc_spi \
	pony_spi \
	realtek_mst_i2c_spi \
	serprog

ifeq ($(BR2_i386)$(BR2_x86_64),y)
FLASHROM_PROGRAMMERS += rayer_spi
endif

ifeq ($(BR2_PACKAGE_LIBFTDI1),y)
FLASHROM_DEPENDENCIES += host-pkgconf libftdi1
FLASHROM_PROGRAMMERS += \
	ft2232_spi \
	usbblaster_spi
endif

ifeq ($(BR2_PACKAGE_LIBUSB),y)
FLASHROM_DEPENDENCIES += host-pkgconf libusb
FLASHROM_PROGRAMMERS += \
	ch341a_spi \
	dediprog \
	developerbox_spi \
	digilent_spi \
	dirtyjtag_spi \
	pickit2_spi \
	raiden_debug_spi \
	stlinkv3_spi
endif

ifeq ($(BR2_PACKAGE_PCIUTILS),y)
FLASHROM_DEPENDENCIES += pciutils
FLASHROM_PROGRAMMERS += \
	atavia \
	drkaiser \
	gfxnvidia \
	internal \
	it8212 \
	nicintel \
	nicintel_eeprom \
	nicintel_spi \
	ogp_spi \
	satasii

ifeq ($(BR2_i386)$(BR2_x86_64),y)
FLASHROM_PROGRAMMERS += \
	atahpt \
	atapromise \
	nic3com \
	nicnatsemi \
	nicrealtek \
	satamv
endif
endif

FLASHROM_CONF_OPTS += -Dprogrammer=$(subst $(space),$(comma),$(strip $(FLASHROM_PROGRAMMERS)))

ifeq ($(BR2_SHARED_LIBS),y)
FLASHROM_CONF_OPTS += --default-library=both
endif

$(eval $(meson-package))
