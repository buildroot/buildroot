################################################################################
#
# raspberrypi-usbboot
#
################################################################################

RASPBERRYPI_USBBOOT_VERSION = 9324fd7034b9d3606aed8a27da74d6d57e066e7e
RASPBERRYPI_USBBOOT_SITE = $(call github,raspberrypi,usbboot,$(RASPBERRYPI_USBBOOT_VERSION))
RASPBERRYPI_USBBOOT_LICENSE = Apache-2.0
RASPBERRYPI_USBBOOT_LICENSE_FILES = LICENSE

HOST_RASPBERRYPI_USBBOOT_DEPENDENCIES = host-libusb

define HOST_RASPBERRYPI_USBBOOT_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_CONFIGURE_OPTS) -C $(@D)
endef

define HOST_RASPBERRYPI_USBBOOT_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/rpiboot $(HOST_DIR)/bin/rpiboot
endef

$(eval $(host-generic-package))
