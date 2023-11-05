################################################################################
#
# system-config-printer
#
################################################################################

SYSTEM_CONFIG_PRINTER_VERSION = 1.5.18
SYSTEM_CONFIG_PRINTER_SOURCE = system-config-printer-$(SYSTEM_CONFIG_PRINTER_VERSION).tar.xz
SYSTEM_CONFIG_PRINTER_SITE = https://github.com/OpenPrinting/system-config-printer/releases/download/v$(SYSTEM_CONFIG_PRINTER_VERSION)
SYSTEM_CONFIG_PRINTER_LICENSE = GPL-2.0+
SYSTEM_CONFIG_PRINTER_LICENSE_FILES = COPYING
SYSTEM_CONFIG_PRINTER_DEPENDENCIES = \
	cups host-desktop-file-utils $(TARGET_NLS_DEPENDENCIES) host-pkgconf

ifeq ($(BR2_PACKAGE_LIBGLIB2),y)
SYSTEM_CONFIG_PRINTER_DEPENDENCIES += libglib2
endif

ifeq ($(BR2_PACKAGE_LIBGLIB2)$(BR2_PACKAGE_LIBUSB)$(BR2_PACKAGE_HAS_UDEV),yyy)
SYSTEM_CONFIG_PRINTER_CONF_OPTS += --with-udev-rules=yes
SYSTEM_CONFIG_PRINTER_DEPENDENCIES += libusb udev
else
SYSTEM_CONFIG_PRINTER_CONF_OPTS += --with-udev-rules=no
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
SYSTEM_CONFIG_PRINTER_CONF_OPTS += --with-systemdsystemunitdir=/usr/lib/systemd/system
SYSTEM_CONFIG_PRINTER_DEPENDENCIES += systemd
else
SYSTEM_CONFIG_PRINTER_CONF_OPTS += --with-systemdsystemunitdir=no
endif

$(eval $(autotools-package))
