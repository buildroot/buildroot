################################################################################
#
# raspberrypi-usbboot
#
################################################################################

RASPBERRYPI_USBBOOT_VERSION = 20240926-102326
RASPBERRYPI_USBBOOT_SITE = https://github.com/raspberrypi/usbboot.git
RASPBERRYPI_USBBOOT_SITE_METHOD = git
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
