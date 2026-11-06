################################################################################
#
# python-gpiod
#
################################################################################

PYTHON_GPIOD_VERSION = 2.6.0
PYTHON_GPIOD_SOURCE = gpiod-$(PYTHON_GPIOD_VERSION).tar.gz
PYTHON_GPIOD_SITE = https://files.pythonhosted.org/packages/ae/09/caeafe129570269e85f93f429ac5eb7e15c513b2b788996ee68c640c3fd6
PYTHON_GPIOD_SETUP_TYPE = setuptools
PYTHON_GPIOD_LICENSE = LGPL-2.1+
PYTHON_GPIOD_LICENSE_FILES = LICENSE
PYTHON_GPIOD_DEPENDENCIES = libgpiod2
PYTHON_GPIOD_ENV = LINK_SYSTEM_LIBGPIOD=1

$(eval $(python-package))
