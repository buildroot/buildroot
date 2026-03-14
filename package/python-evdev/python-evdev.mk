################################################################################
#
# python-evdev
#
################################################################################

PYTHON_EVDEV_VERSION = 1.9.3
PYTHON_EVDEV_SOURCE = evdev-$(PYTHON_EVDEV_VERSION).tar.gz
PYTHON_EVDEV_SITE = https://files.pythonhosted.org/packages/a5/f5/397b61091120a9ca5001041dd7bf76c385b3bfd67a0e5bcb74b852bd22a4
PYTHON_EVDEV_SETUP_TYPE = setuptools
PYTHON_EVDEV_LICENSE = Revised BSD License
PYTHON_EVDEV_LICENSE_FILES = LICENSE

PYTHON_EVDEV_BUILD_OPTS = \
	-C--build-option=build_ecodes \
	-C--build-option=--evdev-headers=$(STAGING_DIR)/usr/include/linux/input.h:$(STAGING_DIR)/usr/include/linux/input-event-codes.h:$(STAGING_DIR)/usr/include/linux/uinput.h

$(eval $(python-package))
