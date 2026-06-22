################################################################################
#
# python-gpiod
#
################################################################################

PYTHON_GPIOD_VERSION = 2.5.0
PYTHON_GPIOD_SOURCE = gpiod-$(PYTHON_GPIOD_VERSION).tar.gz
PYTHON_GPIOD_SITE = https://files.pythonhosted.org/packages/fc/c2/c7bc26965855f39ae3e1b09b404a1fdc3b172dac371012c316f5b9b6a314
PYTHON_GPIOD_SETUP_TYPE = setuptools
PYTHON_GPIOD_LICENSE = LGPL-2.1+
PYTHON_GPIOD_LICENSE_FILES = LICENSE
PYTHON_GPIOD_DEPENDENCIES = libgpiod2
PYTHON_GPIOD_ENV = LINK_SYSTEM_LIBGPIOD=1

$(eval $(python-package))
