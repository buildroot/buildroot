################################################################################
#
# python-libevdev
#
################################################################################

PYTHON_LIBEVDEV_VERSION = 0.13.1
PYTHON_LIBEVDEV_SOURCE = libevdev-$(PYTHON_LIBEVDEV_VERSION).tar.gz
PYTHON_LIBEVDEV_SITE = https://files.pythonhosted.org/packages/86/ff/4f8ab38330965168be742b772bcd151a7a052ea17b2481c43a607875d4ed
PYTHON_LIBEVDEV_SETUP_TYPE = hatch
PYTHON_LIBEVDEV_LICENSE = MIT
PYTHON_LIBEVDEV_LICENSE_FILES = COPYING

# Requires a kernel built with user level driver support (uinput).
define PYTHON_LIBEVDEV_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_INPUT_MISC)
	$(call KCONFIG_ENABLE_OPT,CONFIG_INPUT_UINPUT)
endef

$(eval $(python-package))
