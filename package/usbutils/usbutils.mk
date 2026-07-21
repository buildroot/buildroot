################################################################################
#
# usbutils
#
################################################################################

USBUTILS_VERSION = 019
USBUTILS_SOURCE = usbutils-$(USBUTILS_VERSION).tar.xz
USBUTILS_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/usb/usbutils
USBUTILS_DEPENDENCIES = host-pkgconf libudev libusb
USBUTILS_LICENSE = GPL-2.0+, GPL-2.0 (utils), LGPL-2.1+ (config/CI), GPL-2.0 or GPL-3.0 (lsusb.py), CC0-1.0, MIT (ccan)
USBUTILS_LICENSE_FILES = \
	LICENSES/CC0-1.0.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/LGPL-2.1-or-later.txt \
	LICENSES/MIT.txt

ifeq ($(BR2_PACKAGE_LIBICONV),y)
USBUTILS_DEPENDENCIES += libiconv
USBUTILS_LDFLAGS += -liconv
endif

# Nice lsusb.py script only if there's python 3.x
ifeq ($(BR2_PACKAGE_PYTHON3),)
define USBUTILS_REMOVE_PYTHON
	rm -f $(TARGET_DIR)/usr/bin/lsusb.py
endef

USBUTILS_POST_INSTALL_TARGET_HOOKS += USBUTILS_REMOVE_PYTHON
endif

$(eval $(meson-package))
