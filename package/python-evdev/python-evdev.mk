################################################################################
#
# python-evdev
#
################################################################################

PYTHON_EVDEV_VERSION = 1.9.0
PYTHON_EVDEV_SOURCE = evdev-$(PYTHON_EVDEV_VERSION).tar.gz
PYTHON_EVDEV_SITE = https://files.pythonhosted.org/packages/8c/bf/0fe4d372ee62fe5aec06aae2e97c0603d131b8e3cbaffa2329e0bd763a98
PYTHON_EVDEV_SETUP_TYPE = setuptools
PYTHON_EVDEV_LICENSE = Revised BSD License
PYTHON_EVDEV_LICENSE_FILES = LICENSE

PYTHON_EVDEV_BUILD_OPTS = \
	-C--build-option=build_ecodes \
	-C--build-option=--evdev-headers=$(STAGING_DIR)/usr/include/linux/input.h:$(STAGING_DIR)/usr/include/linux/input-event-codes.h:$(STAGING_DIR)/usr/include/linux/uinput.h

$(eval $(python-package))
