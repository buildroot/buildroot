################################################################################
#
# python-evdev
#
################################################################################

PYTHON_EVDEV_VERSION = 1.6.1
PYTHON_EVDEV_SOURCE = evdev-$(PYTHON_EVDEV_VERSION).tar.gz
PYTHON_EVDEV_SITE = https://files.pythonhosted.org/packages/05/50/629b011a7f61cb2fca754ea8631575784bf8605a1ec4d6970a010bc54e2b
PYTHON_EVDEV_SETUP_TYPE = setuptools
PYTHON_EVDEV_LICENSE = Revised BSD License
PYTHON_EVDEV_LICENSE_FILES = LICENSE

PYTHON_EVDEV_BUILD_OPTS = \
	build_ecodes \
	--evdev-headers $(STAGING_DIR)/usr/include/linux/input.h:$(STAGING_DIR)/usr/include/linux/input-event-codes.h:$(STAGING_DIR)/usr/include/linux/uinput.h

$(eval $(python-package))
