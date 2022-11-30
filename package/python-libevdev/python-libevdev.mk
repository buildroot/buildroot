################################################################################
#
# python-libevdev
#
################################################################################

PYTHON_LIBEVDEV_VERSION = 0.11
PYTHON_LIBEVDEV_SOURCE = libevdev-$(PYTHON_LIBEVDEV_VERSION).tar.gz
PYTHON_LIBEVDEV_SITE = https://files.pythonhosted.org/packages/b0/49/2fe589ce1fa6ca0f05ae0b1717923650f2cc6eec6307c71fbc7789738902
PYTHON_LIBEVDEV_SETUP_TYPE = setuptools
PYTHON_LIBEVDEV_LICENSE = MIT
PYTHON_LIBEVDEV_LICENSE_FILES = COPYING

# Requires a kernel built with user level driver support (uinput).
define PYTHON_LIBEVDEV_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_INPUT_MISC)
	$(call KCONFIG_ENABLE_OPT,CONFIG_INPUT_UINPUT)
endef

$(eval $(python-package))
