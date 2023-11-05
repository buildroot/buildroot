################################################################################
#
# flashrom
#
################################################################################

FLASHROM_VERSION = 1.3.0
FLASHROM_SOURCE = flashrom-v$(FLASHROM_VERSION).tar.bz2
FLASHROM_SITE = https://download.flashrom.org/releases
FLASHROM_LICENSE = GPL-2.0+
FLASHROM_LICENSE_FILES = COPYING
FLASHROM_MAKE_OPTS = WARNERROR=no

ifeq ($(BR2_PACKAGE_LIBFTDI1),y)
FLASHROM_DEPENDENCIES += host-pkgconf libftdi1
FLASHROM_MAKE_OPTS += \
	CONFIG_FT2232_SPI=yes \
	CONFIG_USBBLASTER_SPI=yes
else
FLASHROM_MAKE_OPTS += \
	CONFIG_FT2232_SPI=no \
	CONFIG_USBBLASTER_SPI=no
endif

ifeq ($(BR2_PACKAGE_LIBUSB),y)
FLASHROM_DEPENDENCIES += host-pkgconf libusb
FLASHROM_MAKE_OPTS += CONFIG_ENABLE_LIBUSB1_PROGRAMMERS=yes
else
FLASHROM_MAKE_OPTS += CONFIG_ENABLE_LIBUSB1_PROGRAMMERS=no
endif

ifeq ($(BR2_PACKAGE_PCIUTILS),y)
FLASHROM_DEPENDENCIES += pciutils
FLASHROM_MAKE_OPTS += CONFIG_ENABLE_LIBPCI_PROGRAMMERS=yes
else
FLASHROM_MAKE_OPTS += CONFIG_ENABLE_LIBPCI_PROGRAMMERS=no
endif

define FLASHROM_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) -DHAVE_STRNLEN" \
		$(FLASHROM_MAKE_OPTS) -C $(@D)
endef

define FLASHROM_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/flashrom $(TARGET_DIR)/usr/sbin/flashrom
endef

$(eval $(generic-package))
