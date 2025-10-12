################################################################################
#
# python-libevdev
#
################################################################################

PYTHON_LIBEVDEV_VERSION = 0.12
PYTHON_LIBEVDEV_SOURCE = libevdev-$(PYTHON_LIBEVDEV_VERSION).tar.gz
PYTHON_LIBEVDEV_SITE = https://files.pythonhosted.org/packages/61/6b/e0193f4ba0c3b7d20f8f1b961793d39df5538451c0959abb115020d4ec2d
PYTHON_LIBEVDEV_SETUP_TYPE = setuptools
PYTHON_LIBEVDEV_LICENSE = MIT
PYTHON_LIBEVDEV_LICENSE_FILES = COPYING

# Requires a kernel built with user level driver support (uinput).
define PYTHON_LIBEVDEV_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_INPUT_MISC)
	$(call KCONFIG_ENABLE_OPT,CONFIG_INPUT_UINPUT)
endef

$(eval $(python-package))
