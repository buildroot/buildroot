################################################################################
#
# ccid
#
################################################################################

CCID_VERSION = 1.8.4
CCID_SOURCE = ccid-$(CCID_VERSION).tar.xz
CCID_SITE = https://ccid.apdu.fr/files
CCID_LICENSE = LGPL-2.1+
CCID_LICENSE_FILES = COPYING
CCID_INSTALL_STAGING = YES
CCID_DEPENDENCIES = pcsc-lite host-flex host-pkgconf libusb zlib

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
CCID_DEPENDENCIES += udev
CCID_CONF_OPTS += -Dudev-rules=true
else
CCID_CONF_OPTS += -Dudev-rules=false
endif

$(eval $(meson-package))
