################################################################################
#
# python-gpiod
#
################################################################################

PYTHON_GPIOD_VERSION = 2.4.2
PYTHON_GPIOD_SOURCE = gpiod-$(PYTHON_GPIOD_VERSION).tar.gz
PYTHON_GPIOD_SITE = https://files.pythonhosted.org/packages/13/ca/b3bd043091b4462d6c5561f86581f553df102d8990c37938ddbff2823016
PYTHON_GPIOD_SETUP_TYPE = setuptools
PYTHON_GPIOD_LICENSE = LGPL-2.1+
PYTHON_GPIOD_LICENSE_FILES = LICENSE
PYTHON_GPIOD_DEPENDENCIES = libgpiod2
PYTHON_GPIOD_ENV = LINK_SYSTEM_LIBGPIOD=1

$(eval $(python-package))
